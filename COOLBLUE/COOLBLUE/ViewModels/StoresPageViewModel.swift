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
@MainActor
class StoresPageViewModel {
    var stores: [Store] = []

    var sortByLocation: Bool = false {
        didSet {
            applyFilter()
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

    @ObservationIgnored private var fetchStoresTask: Task<Void, Never>?
    @ObservationIgnored private var filterTask: Task<Void, Never>?

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
        fetchStoresTask?.cancel()
        fetchStoresTask = Task {
            isLoading = true
            errorMessage = nil

            do {
                guard !Task.isCancelled else { return }
                stores = try await storesUseCase.execute(forcedRefresh: forcedRefresh)
            } catch is CancellationError {
                print("Fetch cancelled")
            } catch {
                errorMessage = "Error: \(error.localizedDescription)"
            }

            if shouldFilter() {
                applyFilter()
            } else {
                isLoading = false
            }
        }
    }

    private func shouldFilter() -> Bool {
        return sortByLocation || sortByOpeningHours
    }

    private func applyFilter() {
        filterTask?.cancel()

        filterTask = Task { @MainActor in
            isLoading = true
            var tempStores: [Store] = []

            if sortByLocation {
                do {
                    let location = try await locationService.requestCurrentLocationAsync()

                    if Task.isCancelled {
                        print("Filter cancelled")
                        return
                    }

                    tempStores = self.locationSortUseCase.execute(on: location, with: stores)

                    if sortByOpeningHours {
                        tempStores = self.openingHoursSortUseCase.execute(with: tempStores, at: Date())
                    }

                    stores = tempStores
                } catch {

                }
            } else if sortByOpeningHours {
                tempStores = self.openingHoursSortUseCase.execute(with: stores, at: Date())
                stores = tempStores
            } else {
                await fetchStores()
            }

            isLoading = false
        }
    }
}
