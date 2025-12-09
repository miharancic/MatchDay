//
//  DateRange.swift
//  MDKit
//
//  Created by Mihailo Rancic on 9. 12. 2025..
//

import Foundation

public enum DateRange: String, Sendable, CaseIterable {
    case today = "Today"
    case tomorrow = "Tomorrow"
    case nextWeekend = "Next Weekend"
    case afterNextWeekend = "After Next Weekend"
    
    public var range: (start: Date, end: Date) {
        switch self {
        case .today:
            return today()
        case .tomorrow:
            return tomorrow()
        case .nextWeekend:
            return nextWeekend()
        case .afterNextWeekend:
            return afterNextWeekend()
        }
    }

    private func today() -> (start: Date, end: Date) {
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: Date())
        let end = calendar.date(byAdding: .day, value: 1, to: start)!
        return (start, end)
    }

    private func tomorrow() -> (start: Date, end: Date) {
        let calendar = Calendar.current
        let todayStart = calendar.startOfDay(for: Date())
        let start = calendar.date(byAdding: .day, value: 1, to: todayStart)!
        let end = calendar.date(byAdding: .day, value: 2, to: todayStart)!
        return (start, end)
    }

    private func nextWeekend() -> (start: Date, end: Date) {
        let calendar = Calendar.current
        let now = Date()
        
        let nextSaturday = calendar.nextDate(
            after: now,
            matching: DateComponents(weekday: 7), // saturday
            matchingPolicy: .nextTime
        )!
        
        let start = calendar.startOfDay(for: nextSaturday)
        let end = calendar.date(byAdding: .day, value: 2, to: start)! // ends Monday 00:00
        return (start, end)
    }
    
    private func afterNextWeekend() -> (start: Date, end: Date) {
        let calendar = Calendar.current
        let now = Date()

        let nextMonday = calendar.nextDate(
            after: now,
            matching: DateComponents(weekday: 2), // monday
            matchingPolicy: .nextTime
        )!

        let start = calendar.startOfDay(for: nextMonday)
        let end = Date.distantFuture
        return (start, end)
    }
}
