//
//  CustomBtn.swift
//  FlowPocket
//
//  Created by Luiz Gustavo Barros Campos on 02/03/26.
//

import SwiftUI

struct CustomBtn: View {
    let txt: String
    let colorTxt: Color
    let colorBtn: Color
    var tipBottom: Bool?
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(txt)
                .font(.myFont(style: .title2, weight: .medium))
                .foregroundColor(colorTxt)
                .shadow(color: .black.opacity(0.2), radius: 2, x: 1, y: 1.5)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 18)
        .background(colorBtn)
        .clipShape(
            UnevenRoundedRectangle(
                cornerRadii: .init(
                    topLeading: 20,
                    bottomLeading: tipBottom == true ? 0 : 20,
                    bottomTrailing: 20,
                    topTrailing: tipBottom == true ? 20 : 0,
                )
            )
        )
        .shadow(color: .black.opacity(0.6), radius: 2, x: 1.5, y: 1.8)
        .padding(.vertical, 30)
    }
}

#Preview {
    VStack {
        CustomBtn(txt: "Login", colorTxt: .white, colorBtn: .mainBlue) {
            
        }
    }
    .padding()
}
