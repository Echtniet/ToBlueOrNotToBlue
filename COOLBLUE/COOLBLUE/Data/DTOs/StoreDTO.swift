//
//  Store.swift
//  COOLBLUE
//
//  Created by Clinton on 15/07/2025.
//

import Foundation

struct StoreDTO {
    let id: String
    let name: String
    var address: AddressDTO? = nil
    var todayOpeningHours: TodayOpeningHoursDTO? = nil

    init(gqlStore: CoolBlue.GetStoresQuery.Data.Store) {
        self.id = gqlStore.id
        self.name = gqlStore.name
        if let address = gqlStore.address {
            self.address = AddressDTO(gqlAddress: address)
        }
        if let todayOpeningHours = gqlStore.todayOpeningHours {
            self.todayOpeningHours = TodayOpeningHoursDTO(gqlTodayOpeningHours: todayOpeningHours)
        }
    }

    init(id: String, name: String, address: AddressDTO) {
        self.id = id
        self.name = name
        self.address = address
    }
}
