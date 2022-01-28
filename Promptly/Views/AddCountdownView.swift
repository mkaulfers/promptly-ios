//
//  AddCountdownView.swift
//  Promptly
//
//  Created by Matthew Kaulfers on 1/27/22.
//

import SwiftUI

struct AddCountdownView: View {
    var dismissed: () -> ()
    var add: ((date: Date, title: String)) -> ()
    
    @State private var eventDate = Date.now
    @State private var eventTitle = ""

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Spacer()
            
            VStack {
                Divider()
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.promptlyOrange)
                    .frame(width: 100, height: 4)
                
                TextField("", text: $eventTitle)
                    .placeholder(when: eventTitle.isEmpty, placeholder: {
                    Text("Event Title").foregroundColor(.promptlyLightTeal)
                })
                    .underlineTextField()
                    .font(.title)

                

                DatePicker("asdf",selection: $eventDate, in: Date()...)
                    .applyTextColor(.white)
                    .datePickerStyle(GraphicalDatePickerStyle())
                
                HStack(spacing: 50) {

                    Button(action: {
                        withAnimation { dismissed() }
                    }, label: {
                        Image(systemName: "trash")
                            .font(.title)
                            .frame(width: 100)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.promptlyTeal)
                                    .shadow(color: Color.black.opacity(0.4), radius: 3, x: 3, y: 3)
                                    .frame( height: 50)
                            )
                    })
                    
                    Button(action: {
                        add((date: eventDate, title: eventTitle))
                    }, label: {
                        Image(systemName: "checkmark.seal")
                            .font(.title)
                            .frame(width: 100)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.promptlyTeal)
                                    .shadow(color: Color.black.opacity(0.4), radius: 3, x: 3, y: 3)
                                    .frame( height: 50)
                            )
                    })

                }
                .padding()
                .foregroundColor(.promptlyNavy)
            }
            .background(Color.promptlyNavy)
            .shadow(color: Color.black.opacity(0.4), radius: 3, x: 0, y: -3)
        }
    }
}

struct AddCountdownView_Previews: PreviewProvider {
    static var previews: some View {
        AddCountdownView(dismissed: {}, add: {_ in })
    }
}
