//
//  AppCoordinator.swift
//  COOLBLUE
//
//  Created by Clinton on 16/07/2025.
//

import Observation

enum AppRoute: Hashable {
    case storesPage
    case storeDetail(Store)
}

@Observable
final class AppCoordinator {
    var selectedTab: Tab = .stores
    var navigationPath: [Tab] = []

    @ObservationIgnored var storesPageCoordinator: StoresPageCoordinator

    enum Tab {
        case stores
    }

    init(
        storesPageCoordinator: StoresPageCoordinator
    ) {
        self.storesPageCoordinator = storesPageCoordinator
    }

    func navigate(to route: AppRoute) {
        switch route {
        case .storesPage:
            navigationPath.append(selectedTab)
            selectedTab = .stores
        case .storeDetail(_):
            if selectedTab != .stores {
                navigationPath.append(selectedTab)
                self.selectedTab = .stores
            }
            storesPageCoordinator.navigate(to: route)
        }
    }

    func back() {
        let oldTab = selectedTab
        if let lastTab = navigationPath.popLast() {
            self.selectedTab = lastTab
        }
        switch oldTab {
        case .stores:
            storesPageCoordinator.back()
        }
    }
}

