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

class StoresRepository: StoresRepositoryProtocol {

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
        if !forcedRefresh, let cachedStores = dataCache.get() {
            return cachedStores
        }
        let storesDTO = try await apiService.fetchStores()
        let stores = try storesDTO.map { try Store(dto: $0) }
        dataCache.set(stores)
        return stores
    }
}
