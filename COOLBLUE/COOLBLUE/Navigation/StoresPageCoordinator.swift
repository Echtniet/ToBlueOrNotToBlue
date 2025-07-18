//
//  StoresPageCoordinator.swift
//  COOLBLUE
//
//  Created by Clinton on 16/07/2025.
//

import Observation

@Observable
class StoresPageCoordinator {
    var path: [AppRoute] = []

    func navigate(to route: AppRoute) {
        path.append(route)
    }

    func back() {
        path.removeLast()
    }
}
