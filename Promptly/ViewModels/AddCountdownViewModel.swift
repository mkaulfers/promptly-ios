//
//  AddCountdownViewModel.swift
//  Promptly
//
//  Created by Matthew Kaulfers on 1/28/22.
//

import Foundation

class AddCountdownViewModel: ObservableObject {
    @Published var title = ""
    @Published var dateTime = Date()
    
    func canAdd() -> Bool {
        return !title.isEmpty && dateTime > Date()
    }
}
