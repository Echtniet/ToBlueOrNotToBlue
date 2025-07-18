//
//  StoresUseCase.swift
//  COOLBLUE
//
//  Created by Clinton on 15/07/2025.
//

protocol StoresUseCaseProtocol {
    func execute(forcedRefresh: Bool) async throws -> [Store]
}

class StoresUseCase: StoresUseCaseProtocol {
    private let storesRepository: StoresRepositoryProtocol

    init(storesRepository: StoresRepositoryProtocol) {
        self.storesRepository = storesRepository
    }

    func execute(forcedRefresh: Bool = false) async throws -> [Store] {
        return try await storesRepository.getStores(forcedRefresh: forcedRefresh)
    }
}
