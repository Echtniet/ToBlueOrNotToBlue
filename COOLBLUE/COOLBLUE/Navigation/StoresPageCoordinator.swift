//
//  StoresPageCoordinator.swift
//  COOLBLUE
//
//  Created by Clinton on 16/07/2025.
//

import Observation

@Observable
class StoresPageCoordinator {
    var stores: [Store] = []
    var path: [AppRoute] = []

    func navigate(to route: AppRoute) {
        switch route {
        case .storeDetail(let store):
            stores.append(store)
        default:
            break
        }
        if path.isEmpty {
            path.append(route)
        }
    }

    func back() {
        stores.removeLast()
        if stores.isEmpty {
            path.removeLast()
        }
    }
}
