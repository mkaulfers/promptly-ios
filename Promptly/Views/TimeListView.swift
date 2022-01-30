//
//  TimeListView.swift
//  Promptly
//
//  Created by Matthew Kaulfers on 1/27/22.
//

import SwiftUI

struct TimeListView: View {
    @ObservedObject var vm = TimerListViewModel()
    @State var showsAddModal = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            
            List {
                ForEach (vm.events) { event in
                    CountdownView(dueDate: event)
                        .swipeActions(allowsFullSwipe: false) {
                            Button (action: {
                                vm.deleteEvent(event: event)
                            }) { Label("Delete", systemImage: "trash.circle.fill") }
                            .tint(.red)
                            
                            Button (action: {
                                vm.deleteEvent(event: event)
                            }) { Label("Edit", systemImage: "pencil.circle.fill") }
                            .tint(.promptlyTeal)
                        }
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .background(Color.promptlyLightNavy)
                }
            }
            .listStyle(PlainListStyle())
            .background(Color.promptlyLightNavy)
            
            HStack {
                Button(action: {
                    vm.deleteAllEvents()
                }, label: {
                    Text("Dev Tool: Delete All")
                })
                
                Button(action: {
                    withAnimation {
                        showsAddModal.toggle()
                    }
                }, label: {
                    Text("+")
                        .font(.custom("system", size: 50))
                        .frame(width: 70, height: 70)
                        .foregroundColor(.promptlyNavy)
                        .padding(.bottom, 7)
                })
                    .background(
                        Circle()
                            .fill(Color.promptlyTeal)
                            .shadow(color: Color.black.opacity(0.4), radius: 3, x: 3, y: 3))
                    .padding(.trailing, 26)
                    .padding(.bottom, 58)
            }
            
            Rectangle()
                .fill(showsAddModal ? .black.opacity(0.5) : .clear)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    withAnimation { showsAddModal.toggle() }
                }
            
            if showsAddModal {
                AddCountdownView(dismissed: {
                    withAnimation { showsAddModal.toggle() }
                }, add: { date, title in
                    withAnimation { showsAddModal.toggle() }
                    vm.addEvent(event: Event(date: date, title: title))
                })
                    .transition(.move(edge: .bottom))
            }
        }.edgesIgnoringSafeArea(.bottom)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TimeListView()
    }
}
