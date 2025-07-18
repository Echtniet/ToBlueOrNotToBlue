//
//  TodayOpeningHoursDTO.swift
//  COOLBLUE
//
//  Created by Clinton on 18/07/2025.
//

import Foundation

struct TodayOpeningHoursDTO {
    let scheduleDate: String
    let openTime: String?
    let closeTime: String?

    init(gqlTodayOpeningHours: CoolBlue.GetStoresQuery.Data.Store.TodayOpeningHours) {
        self.scheduleDate = gqlTodayOpeningHours.scheduleDate
        self.openTime = gqlTodayOpeningHours.openTime
        self.closeTime = gqlTodayOpeningHours.closeTime
    }
}
