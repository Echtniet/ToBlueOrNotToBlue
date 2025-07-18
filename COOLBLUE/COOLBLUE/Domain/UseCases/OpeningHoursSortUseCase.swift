//
//  Untitled.swift
//  COOLBLUE
//
//  Created by Clinton on 15/07/2025.
//

protocol OpeningHoursSortUseCaseProtocol {
    func execute(with stores: [Store]) -> [Store]
}

class OpeningHoursSortUseCase: OpeningHoursSortUseCaseProtocol {
    func execute(with stores: [Store]) -> [Store] {
        let now =  Time.currentSecondsSinceMidnight

        return stores.sorted { a, b in
            let aClose = a.todayOpeningHours?.closeTime?.secondsSinceMidnight
            let bClose = b.todayOpeningHours?.closeTime?.secondsSinceMidnight

            switch (aClose, bClose) {
            case let (.some(closeA), .some(closeB)):
                let aPassed = now > closeA
                let bPassed = now > closeB

                switch (aPassed, bPassed) {
                case (true, false):
                    return true
                case (false, true):
                    return false
                default:
                    return false
                }

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
