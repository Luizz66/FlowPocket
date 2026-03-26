//
//  CustomClipShapeRounded.swift
//  FlowPocket
//
//  Created by Luiz Gustavo Barros Campos on 26/03/26.
//

import SwiftUI

extension View {
    func customClipShapeRounded() -> some View {
        self.clipShape(
        UnevenRoundedRectangle(
                cornerRadii: .init(
                    topLeading: 100,
                    bottomLeading: 0,
                    bottomTrailing: 0,
                    topTrailing: 0
                )
            )
        )
    }
}
