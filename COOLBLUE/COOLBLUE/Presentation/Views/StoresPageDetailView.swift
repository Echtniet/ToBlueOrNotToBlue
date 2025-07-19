//
//  StoresPageDetailView.swift
//  COOLBLUE
//
//  Created by Clinton on 16/07/2025.
//

import SwiftUI

struct StoresPageDetailView: View {

    @State private var viewModel: StoresPageDetailViewModel
    @State private var coordinator: AppCoordinator

    init() {
        _viewModel = State(wrappedValue: DIContainer.shared.container.resolve(StoresPageDetailViewModel.self)!)
        _coordinator = State(wrappedValue: DIContainer.shared.container.resolve(AppCoordinator.self)!)
    }

    var body: some View {
        VStack(alignment: .leading) {
            if let store = coordinator.storesPageCoordinator.stores.last {
                Text(store.name)
                if let address = store.address {
                    Text(address.formatted)
                }
                if let openingTime = store.todayOpeningHours?.openTime, let closingTime = store.todayOpeningHours?.closeTime {
                    Text("\(openingTime.formattedHourMinute)-\(closingTime.formattedHourMinute)")
                }
            }
            ScrollView {
                LazyVStack {
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                    } else if viewModel.isLoading {
                        Text("Loading...")
                    } else if viewModel.stores.isEmpty {
                        Text("No stores found")
                    } else {
                        ForEach(viewModel.stores, id: \.self) { store in
                            StoreCard(store: store) {
                                coordinator.navigate(to: .storeDetail(store))
                            }
                        }
                    }
                }
            }
            .refreshable {
                Task {
                    await viewModel.fetchStores(forcedRefresh: true)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .task {
            if viewModel.stores.isEmpty {
                await viewModel.fetchStores()
            }
        }
    }
}
