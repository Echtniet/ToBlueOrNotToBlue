//
//  TodayOpeningHours.swift
//  COOLBLUE
//
//  Created by Clinton on 18/07/2025.
//

import Foundation

struct TodayOpeningHours: Hashable {
    let scheduleDate: Date
    var openTime: Time? = nil
    var closeTime: Time? = nil

    init(dto: TodayOpeningHoursDTO) throws {
        self.scheduleDate = try dto.scheduleDate.toISODate()
        if let openTime = dto.openTime {
            self.openTime = try Time(from: openTime)
        }
        if let closeTime = dto.closeTime {
            self.closeTime = try Time(from: closeTime)
        }
    }
}

extension String {
    func toISODate() throws -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        if let date = formatter.date(from: self) {
            return date
        }
        throw NSError(domain: "Date Error", code: 0, userInfo: nil)
    }
}
