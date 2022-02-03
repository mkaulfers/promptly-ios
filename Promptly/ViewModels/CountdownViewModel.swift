//
//  CountdownViewBaseViewController.swift
//  Promptly
//
//  Created by Matthew Kaulfers on 2/3/22.
//

import Foundation

class CountdownViewModel: ObservableObject {
    @Published var isMinimal = true
    
    func toggleViewMode() {
        isMinimal.toggle()
    }
}
