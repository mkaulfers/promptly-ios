//
//  TimerListViewViewModel.swift
//  Promptly
//
//  Created by Matthew Kaulfers on 1/27/22.
//

import Foundation

class TimerListViewModel: ObservableObject {
    @Published var events: [Event] = []
    let sessionDate = Date()
    
    private var timer = Timer()
    
    //MARK: - LifeCyle & Class Functions
    init() {
        fetchDueDates()
        startUpdatingDates()
    }
    
    deinit {
        timer.invalidate()
    }
    
    
    //TODO: Optimize fetching and updating.
    // Currently updating happens by fetching UD's over and over again and that forces the events to become updated.
    // That's a major CPU hog and it needs to be reduced to only checking time, per cell or something of the sorts. 
    private func fetchDueDates() {
        if let data = UserDefaults.standard.data(forKey: "saved_events") {
            if let decoded = try? JSONDecoder().decode([Event].self, from: data) {
                events = decoded
                return
            }
        }
    }
    
    private func startUpdatingDates() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            self.fetchDueDates()
        })
    }
    
    //MARK: - Accessible Functions
    func addEvent(event: Event) {
        events.append(event)
        if let encoded = try? JSONEncoder().encode(events) {
            UserDefaults.standard.set(encoded, forKey: "saved_events")
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
}
