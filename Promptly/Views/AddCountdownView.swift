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
    
    @ObservedObject var vm = AddCountdownViewModel()
    
    var body: some View {
        
        VStack {
            
            RoundedRectangle(cornerRadius: 2)
                .fill(Color.promptlyOrange)
                .frame(width: 100, height: 4)
            
            TextField("", text: $vm.title)
                .underlineTextField()
                .placeholder(when: vm.title.isEmpty, placeholder: {
                    Text("Event Title").foregroundColor(.promptlyLightTeal)
                        .padding(.horizontal, 10)
                })
                .font(.title)
            
            DatePicker("asdf", selection: $vm.dateTime, in: Date()...)
                .datePickerStyle(GraphicalDatePickerStyle())
                .accentColor(.promptlyOrange)
                .colorScheme(.dark)
            
            HStack(spacing: 0) {
                
                Spacer()
                Button(action: {
                    withAnimation { dismissed() }
                }, label: {
                    Image(systemName: "slash.circle")
                        .font(.title)
                        .frame(width: 70)
                        .background(
                            Rectangle()
                                .fill(.red)
                                .frame(height: 50)
                                .cornerRadius(5, corners: [.topLeft, .bottomLeft])
                        )
                })
                
                Button(action: {
                    add((date: vm.dateTime, title: vm.title))
                }, label: {
                    Image(systemName: "checkmark.circle")
                        .font(.title)
                        .frame(width: 70)
                        .background(
                            Rectangle()
                                .fill(vm.canAdd() ? Color.promptlyTeal : Color.promptlyLightGray)
                                .frame(height: 50)
                                .cornerRadius(5, corners: [.topRight, .bottomRight])
                        )
                }).disabled(!vm.canAdd())
            }
            .padding(.horizontal, 26)
            .padding(.bottom, 58)
            .foregroundColor(.promptlyNavy)
        }
        .background(Color.promptlyNavy.shadow(color: Color.black.opacity(0.4), radius: 3, x: 0, y: -3))
    }
}

struct AddCountdownView_Previews: PreviewProvider {
    static var previews: some View {
        AddCountdownView(dismissed: { }, add: { _ in })
    }
}
