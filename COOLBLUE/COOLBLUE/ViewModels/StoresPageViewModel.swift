//
//  StoresPageViewModel.swift
//  COOLBLUE
//
//  Created by Clinton on 15/07/2025.
//

import Combine
import Foundation
import Observation

@Observable
class StoresPageViewModel {
    var stores: [Store] = [] {
        didSet {
            applyFilter()
        }
    }
    var sortedStores: [Store] = []

    var sortByLocation: Bool = false {
        didSet {
            applyFilter()
        }
    }
    var sortByOpeningHours: Bool = false{
        didSet {
            applyFilter()
        }
    }

    var isLoading: Bool = false
    var errorMessage: String?

    @ObservationIgnored private let locationService: LocationServiceProtocol

    @ObservationIgnored private let storesUseCase: StoresUseCaseProtocol
    @ObservationIgnored private let locationSortUseCase: LocationSortUseCaseProtocol
    @ObservationIgnored private let openingHoursSortUseCase: OpeningHoursSortUseCaseProtocol

    @ObservationIgnored private var cancellables = Set<AnyCancellable>()

    init(
        locationService: LocationServiceProtocol,
        storesUseCase: StoresUseCaseProtocol,
        locationSortUseCase: LocationSortUseCaseProtocol,
        openingHoursSortUseCase: OpeningHoursSortUseCaseProtocol
    ) {
        self.locationService = locationService
        self.storesUseCase = storesUseCase
        self.locationSortUseCase = locationSortUseCase
        self.openingHoursSortUseCase = openingHoursSortUseCase
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

    private func applyFilter() {
        sortedStores = []
        var tempStores = stores

        if sortByLocation {
            locationService.requestCurrentLocation()
                .receive(on: DispatchQueue.main)
                .sink { [weak self] location in
                    guard let self else { return }

                    tempStores = self.locationSortUseCase.execute(on: location, with: tempStores)

                    if sortByOpeningHours {
                        tempStores = self.openingHoursSortUseCase.execute(with: tempStores, at: Date())
                    }

                    sortedStores = tempStores
                }
                .store(in: &cancellables)
        }

        if sortByOpeningHours {
            tempStores = self.openingHoursSortUseCase.execute(with: tempStores, at: Date())
            sortedStores = tempStores
        }

    }
}
