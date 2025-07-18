//
//  StoresIntegrationTest.swift
//  COOLBLUE
//
//  Created by Clinton on 18/07/2025.
//

import Testing
@testable import COOLBLUE
import Foundation

struct StoresIntegrationTest {

    @Test func testStoresFetchingFlow() async throws {
        let mockAPIService = MockAPIService()
        mockAPIService.mockStoresDTO = []

        let repository  = StoresRepository(
            apiService: mockAPIService,
            dataCache: DataCache<[Store]>()
        )
        let useCase = StoresUseCase(storesRepository: repository)
        let viewModel = StoresPageViewModel(
            locationService: MockLocationService(),
            storesUseCase: useCase,
            locationSortUseCase: LocationSortUseCase(),
            openingHoursSortUseCase: OpeningHoursSortUseCase()
        )

        await viewModel.fetchStores()

        #expect(viewModel.stores.isEmpty)
        #expect(viewModel.errorMessage == nil)
    }
}
