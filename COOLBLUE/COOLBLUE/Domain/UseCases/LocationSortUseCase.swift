//
//  LocationSortUseCase.swift
//  COOLBLUE
//
//  Created by Clinton on 15/07/2025.
//

import CoreLocation
import Foundation

protocol LocationSortUseCaseProtocol {
    func execute(on location: CLLocation, with stores: [Store]) -> [Store]
}

actor LocationSortUseCase: LocationSortUseCaseProtocol {
    nonisolated func execute(on location: CLLocation, with stores: [Store]) -> [Store] {
        stores.sorted { a, b in
            switch (a.address?.location, b.address?.location) {
            case let (.some(locA), .some(locB)):
                return location.distance(from: locA) < location.distance(from: locB)
            case (.some, .none):
                return true
            case (.none, .some):
                return false
            case (.none, .none):
                return false
            }
        }
    }
}
