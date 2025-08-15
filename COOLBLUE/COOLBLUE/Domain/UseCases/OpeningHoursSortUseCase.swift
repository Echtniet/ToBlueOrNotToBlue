//
//  Untitled.swift
//  COOLBLUE
//
//  Created by Clinton on 15/07/2025.
//

import Foundation

protocol OpeningHoursSortUseCaseProtocol {
    func execute(with stores: [Store], at currentTime: Date) -> [Store]
}

actor OpeningHoursSortUseCase: OpeningHoursSortUseCaseProtocol {
    nonisolated func execute(with stores: [Store], at currentTime: Date = Date()) -> [Store] {

        return stores.sorted { store1, store2 in
            let store1Open = store1.isOpen(at: currentTime)
            let store2Open = store2.isOpen(at: currentTime)

            if store1Open != store2Open {
                return store1Open
            }

            let store1OpenSoon = store1.opensWithinNext30Minutes(from: currentTime)
            let store2OpenSoon = store2.opensWithinNext30Minutes(from: currentTime)

            if store1OpenSoon != store2OpenSoon {
                return store1OpenSoon
            }

            return false
        }
    }
}
