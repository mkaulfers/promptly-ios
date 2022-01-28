//
//  TimerView.swift
//  Promptly
//
//  Created by Matthew Kaulfers on 1/27/22.
//

import SwiftUI

struct CountdownView: View {
    @ObservedObject var dueDate: Event

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(dueDate.eventTitle)
                    .font(Font.title.bold())
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)

                Spacer()

                if dueDate.typeRemaining != .done {
                    Text("\(dueDate.typeRemaining.rawValue)")
                        .font(Font.footnote)
                } else {
                    Text("\(dueDate.typeRemaining.rawValue)")
                        .font(Font.footnote)
                }
            }
            .frame(height: 30)
            .foregroundColor(Color.promptlyTeal)

            HStack(alignment: .center, spacing: 2) {
                Spacer()

                let digits = dueDate.getFormattedTimeValue(timeValue: getDigits())
                ForEach(Array(digits.enumerated()), id: \.offset) { index, digit in
                    if digit == "," {
                        Text(digit)
                            .foregroundColor(Color.promptlyTeal)
                            .font(Font.headline.bold())
                    } else {
                        Text("\(String(digit))")
                            .foregroundColor(Color.promptlyNavy)
                            .font(Font.title)
                            .frame(width: 35, height: 35)
                            .background(RoundedRectangle(cornerRadius: 5).fill(Color.promptlyOrange))
                    }
                }
            }
        }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(
                Rectangle()
                    .fill(Color.promptlyNavy)
                    .cornerRadius(10, corners: [.topLeft, .bottomLeft])
            )
            .padding(.leading)
    }

    func getDigits() -> Int {
        switch dueDate.typeRemaining {
        case .years:
            return dueDate.yearsRemaining
        case .months:
            return dueDate.monthsRemaining
        case .days:
            return dueDate.daysRemaining
        case .hours:
            return dueDate.hoursRemaining
        case .minutes:
            return dueDate.minutesRemaining
        case .seconds:
            return dueDate.secondsRemaining
        case .done:
            return 0
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        CountdownView(dueDate: Event(date: Date(), title: "Preview Title"))
    }
}
