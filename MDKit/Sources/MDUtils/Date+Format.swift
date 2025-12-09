//
//  Date+Format.swift
//  MDKit
//
//  Created by Mihailo Rancic on 9. 12. 2025..
//

import Foundation

public extension Date {
    static func fromDateTimeString(_ string: String) -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter.date(from: string)
    }
    
    static func fromMilliseconds(_ msString: String) -> Date? {
        guard let ms = Double(msString) else { return nil }
        return Date(timeIntervalSince1970: ms / 1000)
    }
}
