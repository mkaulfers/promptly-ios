//
//  Date+Extensions.swift
//  Promptly
//
//  Created by Matthew Kaulfers on 1/27/22.
//

import Foundation

// Provided By: @Mickael Belhassen
// -- https://stackoverflow.com/questions/50950092/calculating-the-difference-between-two-dates-in-swift
extension Date {
    static func -(recent: Date, previous: Date) -> (year: Int?, month: Int?, day: Int?, hour: Int?, minute: Int?, second: Int?) {
        let year = Calendar.current.dateComponents([.year], from: previous, to: recent).year
        let day = Calendar.current.dateComponents([.day], from: previous, to: recent).day
        let month = Calendar.current.dateComponents([.month], from: previous, to: recent).month
        let hour = Calendar.current.dateComponents([.hour], from: previous, to: recent).hour
        let minute = Calendar.current.dateComponents([.minute], from: previous, to: recent).minute
        let second = Calendar.current.dateComponents([.second], from: previous, to: recent).second
        return (year: year, month: month, day: day, hour: hour, minute: minute, second: second)
    }
}
