//
//  ButtonStyle.swift
//  InvoiceMe
//
//  Created by Rajan Maharjan on 6/11/2023.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding(10)
            .background(RoundedRectangle(cornerRadius: 10.0)
                .foregroundColor(.green))
    }
}

extension ButtonStyle where Self == PrimaryButtonStyle {
    static var primaryButtonStyle: PrimaryButtonStyle { PrimaryButtonStyle() }
}
