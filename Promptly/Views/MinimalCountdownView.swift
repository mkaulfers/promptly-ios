//
//  TimerView.swift
//  Promptly
//
//  Created by Matthew Kaulfers on 1/27/22.
//

import SwiftUI

struct MinimalCountdownView: View {
    @Namespace private var animation
    @ObservedObject var event: Event
    @ObservedObject var vm = CountdownViewModel()
    
    var body: some View {
        VStack {
            if vm.isMinimal {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(event.eventTitle)
                            .font(Font.title.bold())
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                            .matchedGeometryEffect(id: "title", in: animation)
                        
                        Spacer()
                        
                        Text("\(event.typeRemaining.rawValue)")
                            .font(Font.footnote)
                    }
                    .frame(height: 30)
                    .foregroundColor(Color.promptlyTeal)
                    
                    DigitsView(digits: event.getFormattedTimeValue(timeValue: event.getTimeRemainingValue()))
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(
                    Rectangle()
                        .fill(Color.promptlyNavy)
                        .matchedGeometryEffect(id: "background", in: animation)
                        .cornerRadius(10, corners: [.topLeft, .bottomLeft])
                )
                .padding(.leading)
                .padding(.bottom)
            }
            
            if !vm.isMinimal {
                VStack(alignment: .leading, spacing: 8) {
                    VStack(alignment: .leading) {
                        Text(event.eventTitle)
                            .font(Font.title.bold())
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                            .matchedGeometryEffect(id: "title", in: animation)
                        
                        
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
                        .matchedGeometryEffect(id: "background", in: animation)
                )
            }
        }
        .onTapGesture {
            withAnimation(.linear) { vm.toggleViewMode() }
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        MinimalCountdownView(event: Event(date: Date(), title: "Preview Title"))
    }
}
