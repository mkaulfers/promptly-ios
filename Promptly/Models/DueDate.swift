//
//  DueDate.swift
//  Promptly
//
//  Created by Matthew Kaulfers on 1/27/22.
//

import Foundation

class DueDate: ObservableObject, Hashable {
    static func == (lhs: DueDate, rhs: DueDate) -> Bool {
        lhs.identifier == rhs.identifier
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    var identifier = UUID()
    var dueDate: Date

    private var yearsRemaining: Int { (dueDate - Date()).year ?? 0 <= 0 ? 0 : (dueDate - Date()).year ?? 0 }
    private var monthsRemaining: Int { (dueDate - Date()).month ?? 0 <= 0 ? 0 : (dueDate - Date()).month ?? 0 }
    private var daysRemaining: Int { (dueDate - Date()).day ?? 0 <= 0 ? 0 : (dueDate - Date()).day ?? 0 }
    private var hoursRemaining: Int { (dueDate - Date()).hour ?? 0 <= 0 ? 0 : (dueDate - Date()).hour ?? 0 }
    private var minutesRemaining: Int { (dueDate - Date()).minute ?? 0 <= 0 ? 0 : (dueDate - Date()).minute ?? 0 }
    private var secondsRemaining: Int { (dueDate - Date()).second ?? 0 <= 0 ? 0 : (dueDate - Date()).second ?? 0 }

    var typeRemaining: TypeRemaining {

        return yearsRemaining != 0 ? .years:
            monthsRemaining != 0 ? .months:
            daysRemaining != 0 ? .days:
            hoursRemaining != 0 ? .hours:
            minutesRemaining != 0 ? .minutes:
            secondsRemaining != 0 ? .seconds : .done
    }

    var timeRemaining: Int {

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
    
    init(dueDate: Date) {
        self.dueDate = dueDate
    }
}

enum TypeRemaining: String, Hashable {
    case years = "Year(s)"
    case months = "Month(s)"
    case days = "Day(s)"
    case hours = "Hour(s)"
    case minutes = "Minute(s)"
    case seconds = "Second(s)"
    case done = "Done"
}
