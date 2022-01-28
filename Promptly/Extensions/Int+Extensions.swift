//
//  Int+Extensions.swift
//  Promptly
//
//  Created by Matthew Kaulfers on 1/27/22.
//

import Foundation

extension Int {
    func digits() -> [Int] {
        var digits: [Int] = []
        var num = self
        
        digits.append(num % 10)
        
        while num >= 10  {
            num = num / 10
            digits.append(num % 10)
        }
        
        return digits.reversed()
    }
}
