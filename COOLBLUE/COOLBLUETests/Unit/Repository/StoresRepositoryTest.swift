//
//  StoresRepositoryTest.swift
//  COOLBLUE
//
//  Created by Clinton on 18/07/2025.
//

import Testing
@testable import COOLBLUE
import Foundation

class MockAPIService: APIServiceProtocol {

    var mockStoresDTO: [StoreDTO]!
    var shouldThrowError: Bool = false

    func fetchStores() async throws -> [StoreDTO] {
        if shouldThrowError {
            throw NSError(domain: "FetchStoresError", code: 1)
        }
        return mockStoresDTO
    }
}

struct StoresRepositoryTest {

    @Test func testFetchStoresSuccess() async throws {
        let mockAPIService = MockAPIService()
        mockAPIService.mockStoresDTO = []

        let repository = StoresRepository(
            apiService: mockAPIService,
            dataCache: DataCache<[Store]>()
        )

        let storesDTO =  try await repository.getStores(forcedRefresh: false)
        
        #expect(storesDTO.isEmpty)
    }

    @Test func testFetchStoresFailure() async throws {
        let mockAPIService = MockAPIService()
        mockAPIService.shouldThrowError = true
        
        let repository = StoresRepository(
            apiService: mockAPIService,
            dataCache: DataCache<[Store]>()
        )

        await #expect(throws: NSError.self) {
            _ = try await repository.getStores(forcedRefresh: false)
        }
    }
}
