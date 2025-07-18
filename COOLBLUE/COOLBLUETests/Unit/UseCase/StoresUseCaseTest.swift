//
//  StoresUseCaseTest.swift
//  COOLBLUE
//
//  Created by Clinton on 18/07/2025.
//

import Testing
@testable import COOLBLUE
import Foundation

class MockStoresRepository: StoresRepositoryProtocol {

    var mockStores: [Store]!
    var shouldThrowError: Bool = false

    func getStores(forcedRefresh: Bool) async throws -> [Store] {
        if shouldThrowError {
            throw NSError(domain: "FetchStoresError", code: 1)
        }
        return mockStores
    }
}

struct StoresUseCaseTest {

    @Test func testFetchStoresSuccess() async throws {
        let mockRepo = MockStoresRepository()
        mockRepo.mockStores = [
            .init(id: "1", name: "Fake Store 1"),
            .init(id: "2", name: "Fake Store 2"),
        ]

        let useCase = StoresUseCase(storesRepository: mockRepo)
        let stores = try await useCase.execute()

        #expect(stores.count == 2)
    }

    @Test func testFetchStoresFailure() async throws {
        let mockRepo = MockStoresRepository()
        mockRepo.shouldThrowError = true
        
        let useCase = StoresUseCase(storesRepository: mockRepo)
        
        await #expect(throws: NSError.self) {
            _ = try await useCase.execute()
        }
    }
}

