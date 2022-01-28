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
            ScrollView {
                LazyVStack {
                    ForEach (vm.events) { dueDate in
                        CountdownView(dueDate: dueDate)
                            .shadow(color: Color.black.opacity(0.4), radius: 3, x: 3, y: 3)
                    }
                }
                    .padding(.horizontal)
            }
                .listStyle(PlainListStyle())
                .background(Color.promptlyLightNavy)

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
                .padding()

            Rectangle()
                .fill(showsAddModal ? Color.promptlyNavy.opacity(0.8) : .clear)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                withAnimation { showsAddModal.toggle() }
            }

            AddCountdownView(dismissed: {
                withAnimation { showsAddModal.toggle() }
            }, add: { date, title in
                vm.addEvent(event: Event(date: date, title: title))
                }).offset(y: showsAddModal ? 0 : UIScreen.main.bounds.height)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TimeListView()
    }
}
