//
//  StoresRepository.swift
//  COOLBLUE
//
//  Created by Clinton on 15/07/2025.
//

import Foundation

protocol StoresRepositoryProtocol {
    func getStores(forcedRefresh: Bool) async throws -> [Store]
}

actor StoresRepository: StoresRepositoryProtocol {

    private let apiService: APIServiceProtocol
    private let dataCache: DataCache<[Store]>
    
    init(
        apiService: APIServiceProtocol,
        dataCache: DataCache<[Store]>
    ) {
        self.apiService = apiService
        self.dataCache = dataCache
    }
    
    func getStores(forcedRefresh: Bool) async throws -> [Store] {
        try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
        if !forcedRefresh, let cachedStores = await dataCache.get() {
            return cachedStores
        }
        let storesDTO = try await apiService.fetchStores()
        let stores = try storesDTO.map { try Store(dto: $0) }
        await dataCache.set(stores)
        return stores
    }
}
