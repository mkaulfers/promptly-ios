//
//  ExpandedCountdownView.swift
//  Promptly
//
//  Created by Matthew Kaulfers on 1/29/22.
//

import SwiftUI

struct ExpandedCountdownView: View {
    @ObservedObject var event: Event
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            VStack(alignment: .leading) {
                Text(event.eventTitle)
                    .font(Font.title.bold())
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                
                
                Text("- \(event.eventDate.formatted(date: .complete, time: .shortened))")
                    .font(Font.subheadline)
                
            }
            .foregroundColor(Color.promptlyTeal)

            // TOOD: Remove any references that may have 0 for a value. No need to show years if years don't exist. 
            VStack {
                ForEach(TypeRemaining.allCases, id: \.self) { type in
                    if type != .done {
                        VStack(alignment:.trailing, spacing: 0) {
                            Text("\(type.rawValue)").font(Font.footnote)
                            DigitsView(digits: event.getFormattedTimeValue(timeValue: event.getTimeRemainingValue(type: type)))
                        }
                    }
                }
                
            }.foregroundColor(.promptlyLightGray)
            
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(
            Rectangle()
                .fill(Color.promptlyNavy)
        )
    }
    
    
}

struct ExpandedCountdownView_Previews: PreviewProvider {
    static var previews: some View {
        ExpandedCountdownView(event: Event(date: Calendar.current.date(byAdding: .year, value: 3, to: Date())!, title: "Test Title"))
    }
}
