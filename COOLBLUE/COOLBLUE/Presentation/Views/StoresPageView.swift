//
//  StoresPageView.swift
//  COOLBLUE
//
//  Created by Clinton on 16/07/2025.
//

import SwiftUI

struct StoresPageView: View {

    @State private var viewModel: StoresPageViewModel
    @State private var coordinator: StoresPageCoordinator

    init() {
        _viewModel = State(wrappedValue: DIContainer.shared.container.resolve(StoresPageViewModel.self)!)
        _coordinator = State(wrappedValue: DIContainer.shared.container.resolve(StoresPageCoordinator.self)!)
    }

    var body: some View {
        VStack {
            Toggle("On location", isOn: $viewModel.sortByLocation)
                .padding(.horizontal)
            Toggle("On opening hours", isOn: $viewModel.sortByOpeningHours)
                .padding(.horizontal)
            ScrollView {
                LazyVStack {
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                    } else if viewModel.isLoading {
                        Text("Loading...")
                    } else if viewModel.stores.isEmpty && viewModel.sortedStores.isEmpty {
                        Text("No stores found")
                    } else {
                        let storesToDisplay = viewModel.sortedStores.isEmpty ? viewModel.stores : viewModel.sortedStores
                        ForEach(storesToDisplay, id: \.self) { store in
                            StoreCard(store: store) {
                                coordinator.navigate(to: .storeDetail(store))
                            }
                        }
                    }
                }
                .padding()
            }
            .refreshable {
                Task {
                    await viewModel.fetchStores(forcedRefresh: true)
                }
            }
        }
        .task {
            if viewModel.stores.isEmpty {
                await viewModel.fetchStores()
            }
        }
    }
}
