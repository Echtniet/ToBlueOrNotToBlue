//
//  Store.swift
//  COOLBLUE
//
//  Created by Clinton on 15/07/2025.
//

import Foundation

struct Store: Hashable {
    let id: String
    let name: String
    var address: Address? = nil
    var todayOpeningHours: TodayOpeningHours? = nil

    init(dto: StoreDTO) throws {
        self.id = dto.id
        self.name = dto.name
        if let addressDTO = dto.address {
            self.address = Address(dto: addressDTO)
        }
        if let todayOpeningHoursDTO = dto.todayOpeningHours {
            self.todayOpeningHours = try TodayOpeningHours(dto: todayOpeningHoursDTO)
        }
    }

    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}

enum OpenStatus {
    case open, openingSoon, closingSoon, closed
}

extension Store {
    func isOpen(at time: Date) -> Bool {
        let open = todayOpeningHours?.openTime?.toDate(today: time)
        let close = todayOpeningHours?.closeTime?.toDate(today: time)

        if let open, let close {
            return time >= open && time <= close
        }
        return false
    }

    func opensWithinNext30Minutes(from time: Date) -> Bool {
        let open = todayOpeningHours?.openTime?.toDate(today: time)

        if let open {
            return open > time && open <= time.addingTimeInterval(30 * 60)
        }
        return false
    }

    func closesWithinNext30Minutes(from time: Date) -> Bool {
        let close = todayOpeningHours?.closeTime?.toDate(today: time)
        
        if let close {
            return close > time && close <= time.addingTimeInterval(30 * 60)
        }
        return false
    }

    var openingStatus: OpenStatus {
        if opensWithinNext30Minutes(from: Date()) {
            return .openingSoon
        } else if closesWithinNext30Minutes(from: Date()) {
            return .closingSoon
        } else if isOpen(at: Date()) {
            return .open
        } else {
            return .closed
        }
    }
}
