//
//  CustomBtn.swift
//  FlowPocket
//
//  Created by Luiz Gustavo Barros Campos on 02/03/26.
//

import SwiftUI

struct CustomBtn: View {
    let txt: String
    var colorTxt: Color? = .white
    let colorBtn: Color
    var tipTop: Bool?
    let action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            Text(txt)
                .font(.myFont(style: .title2, weight: .medium))
                .foregroundColor(colorTxt)
                .shadow(color: .black.opacity(0.2), radius: 2, x: 1, y: 1.5)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 15)
        }
        .buttonStyle(CustomPressStyle(colorBtn: colorBtn, tipTop: tipTop))
        .shadow(color: .black.opacity(0.6), radius: 2, x: 1.5, y: 1.8)
        .padding(.vertical, 3)
    }
}

private struct CustomPressStyle: ButtonStyle {
    let colorBtn: Color
    var tipTop: Bool?

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(
                colorBtn.opacity(configuration.isPressed ? 0.7 : 1)
            )
            .clipShape(
                UnevenRoundedRectangle(
                    cornerRadii: .init(
                        topLeading: 29,
                        bottomLeading: tipTop == false ? 2 : 29,
                        bottomTrailing: 29,
                        topTrailing: tipTop == false ? 29 : 2
                    )
                )
            )
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.easeInOut(duration: 0.20),
                       value: configuration.isPressed)
    }
}

// MARK: - Preview
private struct CustomBtnView_PreviewContainer: View {
    var body: some View {
        VStack {
            CustomBtn(
                txt: "Login",
                colorTxt: .white,
                colorBtn: .mainBlue
            ) { print("login") }
            
            //style tipBottom
            CustomBtn(
                txt: "Deletar",
                colorTxt: .black,
                colorBtn: .orange,
                tipTop: false
            ) { }
        }
        .padding()
    }
}

struct CustomBtnView_Previews: PreviewProvider {
    static var previews: some View {
        CustomBtnView_PreviewContainer()
            .previewDisplayName("Btn Light Mode")
            .preferredColorScheme(.light)
        
        CustomBtnView_PreviewContainer()
            .previewDisplayName("Btn Dark Mode")
            .preferredColorScheme(.dark)
    }
}
