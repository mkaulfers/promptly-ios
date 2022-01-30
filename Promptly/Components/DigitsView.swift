//
//  DigitsView.swift
//  Promptly
//
//  Created by Matthew Kaulfers on 1/29/22.
//

import SwiftUI

struct DigitsView: View {
    let digits: [String]
    
    var body: some View {
        HStack(spacing: 2) {
            Spacer()
            
            ForEach(Array(digits.enumerated()), id: \.offset) { index, digit in
                if digit == "," {
                    Text(digit)
                        .foregroundColor(Color.promptlyTeal)
                        .font(Font.headline.bold())
                } else {
                    Text("\(String(digit))")
                        .foregroundColor(Color.promptlyNavy)
                        .font(Font.title)
                        .frame(width: 35, height: 35)
                        .background(RoundedRectangle(cornerRadius: 5).fill(Color.promptlyOrange))
                }
            }
        }
    }
}
