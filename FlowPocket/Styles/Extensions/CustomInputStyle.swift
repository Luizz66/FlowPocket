//
//  CustomInputStyle.swift
//  FlowPocket
//
//  Created by Luiz Gustavo Barros Campos on 30/03/26.
//

import SwiftUI

extension View {
    func customInputStyle() -> some View {
        self.padding(10)
            .background(Color.backdrop)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: .black.opacity(0.6), radius: 2, x: 1.5, y: 1.8)
    }
}
