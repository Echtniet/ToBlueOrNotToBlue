//
//  AppView.swift
//  COOLBLUE
//
//  Created by Clinton on 16/07/2025.
//

import SwiftUI

struct AppView: View {

    @State private var coordinator: AppCoordinator

    init() {
        _coordinator = State(wrappedValue: DIContainer.shared.container.resolve(AppCoordinator.self)!)

        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        TabView(selection: $coordinator.selectedTab) {
            NavigationStack(path: $coordinator.storesPageCoordinator.path) {
                StoresPageView()
                    .navigationDestination(for: AppRoute.self) { route in
                        switch route {
                        case .storeDetail(_):
                            StoresPageDetailView()
                                .navigationBarBackButtonHidden(true)
                                .toolbar {
                                    ToolbarItem(placement: .navigationBarLeading) {
                                        Button {
                                            coordinator.back()
                                        } label: {
                                            HStack {
                                                Image(systemName: "chevron.left")
                                                Text("Back")
                                            }
                                            .foregroundStyle(.blue)
                                        }
                                        .accessibilityIdentifier("BackButtonStoreDetail")
                                    }
                                }
                        default:
                            EmptyView()
                        }
                    }
            }
            .tabItem {
                Image(systemName: "storefront.fill")
                Text("Stores")
            }
            .tag(AppCoordinator.Tab.stores)
        }
    }
}


