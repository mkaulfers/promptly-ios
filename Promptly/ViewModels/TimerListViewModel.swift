//
//  TimerListViewViewModel.swift
//  Promptly
//
//  Created by Matthew Kaulfers on 1/27/22.
//

import SwiftUI

class TimerListViewModel: ObservableObject {
    @Published var events: [Event] = []
    private var timer = Timer()
    
    //MARK: - LifeCyle & Class Functions
    init() {
        fetchDueDates()
        beginUpdatingEvents()
    }
    
    deinit {
        timer.invalidate()
    }
    
    private func fetchDueDates() {
        if let data = UserDefaults.standard.data(forKey: "saved_events") {
            if let decoded = try? JSONDecoder().decode([Event].self, from: data) {
                events = decoded
                return
            }
        }
    }
    
    //MARK: - Accessible Functions
    func addEvent(event: Event) {
        events.append(event)
        
        if !timer.isValid {
            beginUpdatingEvents()
        }
        
        if let encoded = try? JSONEncoder().encode(events) {
            UserDefaults.standard.set(encoded, forKey: "saved_events")
        }
    }
    
    func deleteEvent(event: Event) {
        events.remove(at: events.firstIndex(where: {$0.eventID == event.eventID}) ?? 0)
        if let encoded = try? JSONEncoder().encode(events) {
            UserDefaults.standard.set(encoded, forKey: "saved_events")
        }
    }
    
    func deleteAllEvents() {
        for event in events {
            deleteEvent(event: event)
        }
        timer.invalidate()
    }
    
    private func beginUpdatingEvents() {
        var secondsElapsed = 0
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [self] timer in
            secondsElapsed += 1
            for event in events where event.typeRemaining != .done {
                let calculatedDate = (event.eventDate - Date())
                
                if calculatedDate.year ?? 0 <= 0 &&
                    calculatedDate.month ?? 0 <= 0 &&
                    calculatedDate.day ?? 0 <= 0 &&
                    calculatedDate.hour ?? 0 <= 0 &&
                    calculatedDate.minute ?? 0 <= 0 &&
                    calculatedDate.second ?? 0 <= 0 {
                    event.typeRemaining = .done
                } else {
                    // If calculated date is less than or equal to 0 then 0 else return the value
                    event.yearsRemaining = calculatedDate.year ?? 0 <= 0 ? 0 : calculatedDate.year ?? 0
                    event.monthsRemaining = calculatedDate.month ?? 0 <= 0 ? 0 : calculatedDate.month ?? 0
                    event.daysRemaining = calculatedDate.day ?? 0 <= 0 ? 0 : calculatedDate.day ?? 0
                    event.hoursRemaining = calculatedDate.hour ?? 0 <= 0 ? 0 : calculatedDate.hour ?? 0
                    event.minutesRemaining = calculatedDate.minute ?? 0 <= 0 ? 0 : calculatedDate.minute ?? 0
                    event.secondsRemaining = calculatedDate.second ?? 0 <= 0 ? 0 : calculatedDate.second ?? 0
                    
//                    print("Years: \(event.yearsRemaining)")
//                    print("Months: \(event.monthsRemaining)")
//                    print("Days: \(event.daysRemaining)")
//                    print("Hours: \(event.hoursRemaining)")
//                    print("Minutes: \(event.minutesRemaining)")
//                    print("Seconds: \(event.secondsRemaining)")
                }
            }
            
            // Every 5 seconds, go to the next available type, which is NOT 0
            if secondsElapsed % 5 == 0 {
                for event in events where event.typeRemaining != .done {
                    print("Fired")
                    goToNextTypeFrom(event: event)
                }
            }
        })
    }
    
    private func goToNextTypeFrom(event: Event) {
        var availableTypes: [TypeRemaining] = []

        if event.yearsRemaining > 0 { availableTypes.append(.years) }
        if event.monthsRemaining > 0 { availableTypes.append(.months) }
        if event.daysRemaining > 0 { availableTypes.append(.days) }
        if event.hoursRemaining > 0 { availableTypes.append(.hours) }
        if event.minutesRemaining > 0 { availableTypes.append(.minutes) }
        if event.secondsRemaining > 0 { availableTypes.append(.seconds) }

        if availableTypes.count != 0 {
            guard let currentIndex = availableTypes.firstIndex(where: { $0 == event.typeRemaining }) else { return }

            withAnimation(.interactiveSpring()) {
                //Go to next index or first
                if currentIndex >= availableTypes.count - 1 {
                    event.typeRemaining = availableTypes[0]
                } else {
                    event.typeRemaining = availableTypes[currentIndex + 1]
                }
            }
        }
    }
}
