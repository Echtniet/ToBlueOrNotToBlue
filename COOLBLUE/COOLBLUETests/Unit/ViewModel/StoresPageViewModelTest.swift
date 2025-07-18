//
//  StoresPageViewModelTest.swift
//  COOLBLUE
//
//  Created by Clinton on 18/07/2025.
//

import Testing
@testable import COOLBLUE
import Foundation
import Combine
import CoreLocation

class MockLocationService: LocationServiceProtocol {

    private let locationSubject = PassthroughSubject<CLLocation, Never>()

    func requestCurrentLocation() -> AnyPublisher<CLLocation, Never> {
        return locationSubject.eraseToAnyPublisher()
    }
}

class MockStoresUseCase: StoresUseCaseProtocol {

    var mockStores: [Store] = []
    var shouldThrowError: Bool = false

    func execute(forcedRefresh: Bool) async throws -> [Store] {
        if shouldThrowError {
            throw NSError(domain: "FetchStoresError", code: 1)
        }
        return mockStores
    }
}

struct StoresPageViewModelTest {

    @Test func testFetchStoresSuccess() async throws {
        let mockUseCase = MockStoresUseCase()
        mockUseCase.mockStores = [
            .init(id: "1", name: "Fake Store 1"),
            .init(id: "2", name: "Fake Store 2"),
        ]

        let viewModel = StoresPageViewModel(
            locationService: MockLocationService(),
            storesUseCase: mockUseCase,
            locationSortUseCase: LocationSortUseCase(),
            openingHoursSortUseCase: OpeningHoursSortUseCase()
        )

        await viewModel.fetchStores()
        #expect(viewModel.stores.count == 2)
    }

    @Test func testFetchStoresFailure() async throws {
        let mockUseCase = MockStoresUseCase()
        mockUseCase.shouldThrowError = true

        let viewModel = StoresPageViewModel(
            locationService: MockLocationService(),
            storesUseCase: mockUseCase,
            locationSortUseCase: LocationSortUseCase(),
            openingHoursSortUseCase: OpeningHoursSortUseCase()
        )
        
        await viewModel.fetchStores()

        #expect(viewModel.errorMessage != nil)
    }
}
