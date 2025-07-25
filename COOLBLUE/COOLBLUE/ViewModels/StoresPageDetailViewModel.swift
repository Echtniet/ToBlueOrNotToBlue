//
//  StoresPageDetailViewModel.swift
//  COOLBLUE
//
//  Created by Clinton on 19/07/2025.
//

import Foundation
import Observation

@Observable
class StoresPageDetailViewModel {
    var stores: [Store] = []

    var redacted: Bool = false

    var isLoading: Bool = false
    var errorMessage: String?

    @ObservationIgnored private let storesUseCase: StoresUseCaseProtocol

    init(storesUseCase: StoresUseCaseProtocol) {
        self.storesUseCase = storesUseCase
    }

    func fetchStores(forcedRefresh: Bool = false) async {
        isLoading = true
        errorMessage = nil

        do {
            stores = try await storesUseCase.execute(forcedRefresh: forcedRefresh)
        } catch {
            errorMessage = "Error: \(error.localizedDescription)"
        }

        isLoading = false
    }

    func redact() {
        redacted = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.redacted = false
        }
    }
}
