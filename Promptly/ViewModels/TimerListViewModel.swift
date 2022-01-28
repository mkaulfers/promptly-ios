//
//  TimerListViewViewModel.swift
//  Promptly
//
//  Created by Matthew Kaulfers on 1/27/22.
//

import Foundation

class TimerListViewModel: ObservableObject {
    @Published var events: [Event] = []
    
    //MARK: - LifeCyle & Class Functions
    init() {
        fetchDueDates()
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
        if let encoded = try? JSONEncoder().encode(events) {
            UserDefaults.standard.set(encoded, forKey: "saved_events")
        }
    }
    
    func deleteEvent(event: Event) {
        event.stopTimer()
        events.remove(at: events.firstIndex(where: {$0.eventID == event.eventID}) ?? 0)
        if let encoded = try? JSONEncoder().encode(events) {
            UserDefaults.standard.set(encoded, forKey: "saved_events")
        }
    }
}
