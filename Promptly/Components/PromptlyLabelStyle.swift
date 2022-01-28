//
//  PromptlyLabelStyle.swift
//  Promptly
//
//  Created by Matthew Kaulfers on 1/28/22.
//

import SwiftUI

struct PromptlyLabelStyle: LabelStyle {
    let color: Color

    func makeBody(configuration: Configuration) -> some View {
        VStack {
            configuration.title
            configuration.icon
                .foregroundColor(color)
        }
    }
}
