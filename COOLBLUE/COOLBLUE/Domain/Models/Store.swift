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
