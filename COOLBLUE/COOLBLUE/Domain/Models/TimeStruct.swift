//
//  Time.swift
//  COOLBLUE
//
//  Created by Clinton on 18/07/2025.
//

import Foundation

struct Time: Hashable {
    let hour: Int
    let minute: Int
    let seconds: Int

    init(from string: String) throws {
        let components = string.split(separator: ":").map { Int($0) }

        guard
            components.count == 3,
            let hour = components[0],
                let minute = components[1],
                let seconds = components[2]
        else {
            throw NSError(domain: "Time Error", code: 0, userInfo: nil)
        }

        self.hour = hour
        self.minute = minute
        self.seconds = seconds
    }
}

extension Time {
    var secondsSinceMidnight: Int {
        return hour * 3600 + minute * 60 + seconds
    }

    static var currentSecondsSinceMidnight: Int {
        let now = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: now)
        let minute = calendar.component(.minute, from: now)
        let second = calendar.component(.second, from: now)
        return hour * 3600 + minute * 60 + second
    }
    
    func toDate(today: Date = Date()) -> Date {
        let calendar = Calendar.current
        return calendar.date(bySettingHour: hour, minute: minute, second: seconds, of: Date())!
    }
}

extension Time {
    var formattedHourMinute: String {
        String(format: "%02d:%02d", hour, minute)
    }
}
