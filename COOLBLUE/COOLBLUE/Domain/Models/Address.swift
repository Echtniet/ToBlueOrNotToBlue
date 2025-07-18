//
//  Address.swift
//  COOLBLUE
//
//  Created by Clinton on 18/07/2025.
//

import CoreLocation
import Foundation

struct Address: Hashable {
    let street: String
    let houseNumber: String
    let houseNumberAddition: String?
    let postalCode: String
    let country: String
    let location: CLLocation

    init(dto: AddressDTO) {
        self.street = dto.street
        self.houseNumber = dto.houseNumber
        self.houseNumberAddition = dto.houseNumberAddition
        self.postalCode = dto.postalCode
        self.country = dto.country
        self.location = CLLocation(latitude: dto.latitude, longitude: dto.longitude)
    }

    init(street: String, houseNumber: String, houseNumberAddition: String?, postalCode: String, country: String, location: CLLocation) {
        self.street = street
        self.houseNumber = houseNumber
        self.houseNumberAddition = houseNumberAddition
        self.postalCode = postalCode
        self.country = country
        self.location = location
    }
}

extension Address {
    var formatted: String {
        var components: [String] = []

        let fullHouseNumber = houseNumberAddition != nil && !houseNumberAddition!.isEmpty
            ? "\(houseNumber)\(houseNumberAddition!)"
            : houseNumber

        components.append("\(street) \(fullHouseNumber)")
        components.append(postalCode)
        components.append(country)

        return components.joined(separator: ", ")
    }
}
