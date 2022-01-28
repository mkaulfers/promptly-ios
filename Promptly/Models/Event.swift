//
//  DueDate.swift
//  Promptly
//
//  Created by Matthew Kaulfers on 1/27/22.
//

import Foundation

class Event: ObservableObject, Identifiable, Codable {
    // MARK: - PRoperties
    // Coodable Properties
    var eventID: UUID
    var eventDate: Date
    var eventTitle: String
    
    // Calculation Properties
    private var timer: Timer
    private var sessionDate: Date

    // Calculated Properties
    @Published var yearsRemaining: Int = 0
    @Published var monthsRemaining: Int = 0
    @Published var daysRemaining: Int = 0
    @Published var hoursRemaining: Int = 0
    @Published var minutesRemaining: Int = 0
    @Published var secondsRemaining: Int = 0
    
    
    //MARK: - Computed Properties
    var typeRemaining: TypeRemaining {

        return yearsRemaining != 0 ? .years:
            monthsRemaining != 0 ? .months:
            daysRemaining != 0 ? .days:
            hoursRemaining != 0 ? .hours:
            minutesRemaining != 0 ? .minutes:
            secondsRemaining != 0 ? .seconds : .done
    }

//    var timeRemaining: Int {
//
//        switch typeRemaining {
//        case .years:
//            return yearsRemaining
//        case .months:
//            return monthsRemaining
//        case .days:
//            return daysRemaining
//        case .hours:
//            return hoursRemaining
//        case .minutes:
//            return minutesRemaining
//        case .seconds:
//            return secondsRemaining
//        case .done:
//            return 0
//        }
//    }
    
    // MARK: - Initializers & DeInitializer
    init(date: Date, title: String) {
        self.eventID = UUID()
        self.eventDate = date
        self.eventTitle = title
        self.sessionDate = Date()
        self.timer = Timer()
        beginUpdatingTimes()
    }

    init(eventID: UUID, date: Date, title: String) {
        self.eventID = eventID
        self.eventDate = date
        self.eventTitle = title
        self.sessionDate = Date()
        self.timer = Timer()
        beginUpdatingTimes()
    }
    
    deinit {
        timer.invalidate()
    }

    // MARK: - Decoding & Encoding
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
        self.sessionDate = Date()
        self.timer = Timer()
        beginUpdatingTimes()
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

    func beginUpdatingTimes() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [self] _ in
            sessionDate = Date()
            yearsRemaining = (eventDate - sessionDate).year ?? 0 <= 0 ? 0 : (eventDate - sessionDate).year ?? 0
            monthsRemaining = (eventDate - sessionDate).month ?? 0 <= 0 ? 0 : (eventDate - sessionDate).month ?? 0
            daysRemaining = (eventDate - sessionDate).day ?? 0 <= 0 ? 0 : (eventDate - sessionDate).day ?? 0
            hoursRemaining = (eventDate - sessionDate).hour ?? 0 <= 0 ? 0 : (eventDate - sessionDate).hour ?? 0
            minutesRemaining = (eventDate - sessionDate).minute ?? 0 <= 0 ? 0 : (eventDate - sessionDate).minute ?? 0
            secondsRemaining = (eventDate - sessionDate).second ?? 0 <= 0 ? 0 : (eventDate - sessionDate).second ?? 0
            
            print("Years: \(yearsRemaining)")
            print("Months: \(monthsRemaining)")
            print("Days: \(daysRemaining)")
            print("Hours: \(hoursRemaining)")
            print("Minutes: \(minutesRemaining)")
            print("Seconds: \(secondsRemaining)")
            
            if yearsRemaining == 0 &&
                monthsRemaining == 0 &&
                daysRemaining == 0 &&
                hoursRemaining == 0 &&
                minutesRemaining == 0 &&
                secondsRemaining == 0 {
                timer.invalidate()
            }
        })
    }
    
    func stopTimer() {
        timer.invalidate()
    }
}

// MARK: - Enums
enum TypeRemaining: String {
    case years = "Year(s)"
    case months = "Month(s)"
    case days = "Day(s)"
    case hours = "Hour(s)"
    case minutes = "Minute(s)"
    case seconds = "Second(s)"
    case done = "Done"
}
