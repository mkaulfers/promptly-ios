//
//  TimerView.swift
//  Promptly
//
//  Created by Matthew Kaulfers on 1/27/22.
//

import SwiftUI

struct CountdownView: View {
    @ObservedObject var dueDate: DueDate

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text("Going on vacation")
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
            }.foregroundColor(Color.promptlyTeal)

            HStack(alignment: .center, spacing: 2) {
                Spacer()

                let digits = dueDate.getFormattedTimeValue(timeValue: dueDate.timeRemaining)
                ForEach(Array(digits.enumerated()), id: \.offset) { index, digit in
                    if digit == "," {
                        Text(digit)
                            .foregroundColor(Color.promptlyTeal)
                            .font(Font.headline.bold())
                    } else {
                        Text("\(String(digit))")
                            .foregroundColor(Color.promptlyNavy)
                            .font(Font.headline.bold())
                            .frame(width: 25, height: 25)
                            .background(RoundedRectangle(cornerRadius: 5).fill(Color.promptlyOrange))
                    }
                }
            }
        }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.promptlyNavy))
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        CountdownView(dueDate: DueDate(dueDate: Date()))
    }
}
