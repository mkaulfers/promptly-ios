//
//  DueDate.swift
//  Promptly
//
//  Created by Matthew Kaulfers on 1/27/22.
//

import Foundation
import SwiftUI

class Event: ObservableObject, Identifiable, Codable {
    // MARK: - PRoperties
    // Coodable Properties
    var eventID: UUID
    var eventDate: Date
    var eventTitle: String
    
    // Calculated Properties
    @Published var yearsRemaining: Int
    @Published var monthsRemaining: Int
    @Published var daysRemaining: Int
    @Published var hoursRemaining: Int
    @Published var minutesRemaining: Int
    @Published var secondsRemaining: Int
    @Published var typeRemaining: TypeRemaining
    
    // MARK: - Initializers & DeInitializer
    init(date: Date, title: String) {
        self.eventID = UUID()
        self.eventDate = date
        self.eventTitle = title
        
        if let yearsRemaining = (eventDate - Date()).year,
           let monthsRemaining = (eventDate - Date()).month,
           let daysRemaining = (eventDate - Date()).day,
           let hoursRemaining = (eventDate - Date()).hour,
           let minutesRemaining = (eventDate - Date()).minute,
           let secondsRemaining = (eventDate - Date()).second {
            self.yearsRemaining = yearsRemaining
            self.monthsRemaining = monthsRemaining
            self.daysRemaining = daysRemaining
            self.hoursRemaining = hoursRemaining
            self.minutesRemaining = minutesRemaining
            self.secondsRemaining = secondsRemaining
        } else {
            self.yearsRemaining = 0
            self.monthsRemaining = 0
            self.daysRemaining = 0
            self.hoursRemaining = 0
            self.minutesRemaining = 0
            self.secondsRemaining = 0
        }
        
        self.typeRemaining = Event.getTypeRemaining(eventDate: date)
    }
    
    init(eventID: UUID, date: Date, title: String) {
        self.eventID = eventID
        self.eventDate = date
        self.eventTitle = title
        
        if let yearsRemaining = (eventDate - Date()).year,
           let monthsRemaining = (eventDate - Date()).month,
           let daysRemaining = (eventDate - Date()).day,
           let hoursRemaining = (eventDate - Date()).hour,
           let minutesRemaining = (eventDate - Date()).minute,
           let secondsRemaining = (eventDate - Date()).second {
            self.yearsRemaining = yearsRemaining
            self.monthsRemaining = monthsRemaining
            self.daysRemaining = daysRemaining
            self.hoursRemaining = hoursRemaining
            self.minutesRemaining = minutesRemaining
            self.secondsRemaining = secondsRemaining
        } else {
            self.yearsRemaining = 0
            self.monthsRemaining = 0
            self.daysRemaining = 0
            self.hoursRemaining = 0
            self.minutesRemaining = 0
            self.secondsRemaining = 0
        }
        
        self.typeRemaining = Event.getTypeRemaining(eventDate: date)
    }
    
    private enum CodingKeys : String, CodingKey {
        case eventId
        case eventDate
        case eventTitle
    }
    
    required init(from decoder : Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.eventID = try container.decode(UUID.self, forKey: .eventId)
        self.eventDate = try container.decode(Date.self, forKey: .eventDate)
        self.eventTitle = try container.decode(String.self, forKey: .eventTitle)
        
        let calculatedDate = (eventDate - Date())
        
        if let yearsRemaining = calculatedDate.year,
           let monthsRemaining = calculatedDate.month,
           let daysRemaining = calculatedDate.day,
           let hoursRemaining = calculatedDate.hour,
           let minutesRemaining = calculatedDate.minute,
           let secondsRemaining = calculatedDate.second {
            self.yearsRemaining = yearsRemaining
            self.monthsRemaining = monthsRemaining
            self.daysRemaining = daysRemaining
            self.hoursRemaining = hoursRemaining
            self.minutesRemaining = minutesRemaining
            self.secondsRemaining = secondsRemaining
        } else {
            self.yearsRemaining = 0
            self.monthsRemaining = 0
            self.daysRemaining = 0
            self.hoursRemaining = 0
            self.minutesRemaining = 0
            self.secondsRemaining = 0
        }
        
        self.typeRemaining = Event.getTypeRemaining(eventDate: self.eventDate)
    }
    
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(eventID, forKey: .eventId)
        try container.encode(eventDate, forKey: .eventDate)
        try container.encode(eventTitle, forKey: .eventTitle)
    }
    
    // MARK: Class Functions
    func getFormattedTimeValue(timeValue: Int) -> [String] {
        let digits: [Int] = timeValue.digits().reversed()
        var strDigits = digits.map(String.init)
        
        var insertCount = 0
        for (index, _) in strDigits.enumerated() {
            if index % 3 == 0 && index != 0 {
                strDigits.insert(",", at: index + insertCount)
                insertCount += 1
            }
        }
        return strDigits.reversed()
    }
    
    func getTimeRemainingValue() -> Int {
        switch typeRemaining {
        case .years:
            return yearsRemaining
        case .months:
            return monthsRemaining
        case .days:
            return daysRemaining
        case .hours:
            return hoursRemaining
        case .minutes:
            return minutesRemaining
        case .seconds:
            return secondsRemaining
        case .done:
            return 0
        }
    }
    
    func getTimeRemainingValue(type: TypeRemaining) -> Int {
        switch type {
        case .years:
            return yearsRemaining
        case .months:
            return monthsRemaining
        case .days:
            return daysRemaining
        case .hours:
            return hoursRemaining
        case .minutes:
            return minutesRemaining
        case .seconds:
            return secondsRemaining
        case .done:
            return 0
        }
    }

    private class func getTypeRemaining(eventDate: Date) -> TypeRemaining {
        let currentDate = Date()
        let calculatedDate = (eventDate - currentDate)
        
        if calculatedDate.year == 0 &&
            calculatedDate.month == 0 &&
            calculatedDate.day == 0 &&
            calculatedDate.hour == 0 &&
            calculatedDate.minute == 0 &&
            calculatedDate.second == 0 {
            return .done
        } else {
            if calculatedDate.year != 0 { return .years }
            if calculatedDate.month != 0 { return .months }
            if calculatedDate.day != 0 { return .days }
            if calculatedDate.hour != 0 { return .hours }
            if calculatedDate.minute != 0 { return .minutes }
            if calculatedDate.second != 0 { return .seconds }
        }
        
        print("Returned Default In: Event.GetTypeRemaining()")
        return .done
    }
}

// MARK: - Enums
enum TypeRemaining: String, CaseIterable {
    case years = "Year(s)"
    case months = "Month(s)"
    case days = "Day(s)"
    case hours = "Hour(s)"
    case minutes = "Minute(s)"
    case seconds = "Second(s)"
    case done = "Done"
}
