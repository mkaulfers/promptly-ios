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
                
                Text("\(dueDate.typeRemaining.rawValue)")
                    .font(Font.footnote)
            }
            .frame(height: 30)
            .foregroundColor(Color.promptlyTeal)
            
            DigitsView(digits: dueDate.getFormattedTimeValue(timeValue: dueDate.getTimeRemainingValue()))
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(
            Rectangle()
                .fill(Color.promptlyNavy)
                .cornerRadius(10, corners: [.topLeft, .bottomLeft])
        )
        .padding(.leading)
        .padding(.bottom)
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        CountdownView(dueDate: Event(date: Date(), title: "Preview Title"))
    }
}
