//
//  AddressDTO.swift
//  COOLBLUE
//
//  Created by Clinton on 18/07/2025.
//

import Foundation

struct AddressDTO {
    let street: String
    let houseNumber: String
    let houseNumberAddition: String?
    let postalCode: String
    let country: String
    let latitude: Double
    let longitude: Double

    init(gqlAddress: CoolBlue.GetStoresQuery.Data.Store.Address) {
        self.street = gqlAddress.street
        self.houseNumber = gqlAddress.houseNumber
        self.houseNumberAddition = gqlAddress.houseNumberAddition
        self.postalCode = gqlAddress.postalCode
        self.country = gqlAddress.country
        self.latitude = gqlAddress.latitude
        self.longitude = gqlAddress.longitude
    }

    init(street: String, houseNumber: String, houseNumberAddition: String?, postalCode: String, country: String, latitude: Double, longitude: Double) {
        self.street = street
        self.houseNumber = houseNumber
        self.houseNumberAddition = houseNumberAddition
        self.postalCode = postalCode
        self.country = country
        self.latitude = latitude
        self.longitude = longitude
    }
}
