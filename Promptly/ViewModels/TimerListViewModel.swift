//
//  TimerListViewViewModel.swift
//  Promptly
//
//  Created by Matthew Kaulfers on 1/27/22.
//

import Foundation

class TimerListViewModel: ObservableObject {
    @Published var dueDates: [DueDate] = []
    let sessionDate = Date()
    
    private var timer = Timer()
    
    init() {
        fetchDueDates()
        startUpdatingDates()
    }
    
    deinit {
        timer.invalidate()
    }
    
    private func fetchDueDates() {
        dueDates = []
        dueDates.append(DueDate(dueDate: Calendar.current.date(byAdding: .second, value: 111, to: sessionDate)!))
        dueDates.append(DueDate(dueDate: Calendar.current.date(byAdding: .second, value: 151, to: sessionDate)!))
        dueDates.append(DueDate(dueDate: Calendar.current.date(byAdding: .second, value: 124, to: sessionDate)!))
        dueDates.append(DueDate(dueDate: Calendar.current.date(byAdding: .second, value: 3351, to: sessionDate)!))
        dueDates.append(DueDate(dueDate: Calendar.current.date(byAdding: .second, value: 124, to: sessionDate)!))
        dueDates.append(DueDate(dueDate: Calendar.current.date(byAdding: .second, value: 1551, to: sessionDate)!))
    }
    
    private func startUpdatingDates() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            self.fetchDueDates()
        })
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
