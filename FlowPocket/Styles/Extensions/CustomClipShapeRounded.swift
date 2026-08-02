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
                    topLeading: 90,
                    bottomLeading: 0,
                    bottomTrailing: 0,
                    topTrailing: 0
                )
            )
        )
    }
}

// MARK: - Preview
private struct CustomClipShapeRoundedView_PreviewContainer: View {
    var body: some View {
        VStack {
            Image(systemName: "house")
                .padding(.vertical, 100)
            VStack {
                Text("Hello, World!")
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.mainBlue)
            .customClipShapeRounded()
        }
        .ignoresSafeArea()
    }
}

#Preview("Light Mode") {
    CustomClipShapeRoundedView_PreviewContainer()
        .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    CustomClipShapeRoundedView_PreviewContainer()
        .preferredColorScheme(.dark)
}
