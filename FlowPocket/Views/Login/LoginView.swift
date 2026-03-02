//
//  LoginView.swift
//  FlowPocket
//
//  Created by Luiz Gustavo Barros Campos on 01/03/26.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        GeometryReader { geo in
            VStack {
                Image("ImgIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.width / 2.8)
                    .clipShape(
                        UnevenRoundedRectangle(
                            cornerRadii: .init(
                                topLeading: 40,
                                bottomLeading: 0,
                                bottomTrailing: 40,
                                topTrailing: 40
                            )
                        )
                    )
                    .padding(34)
                    .background(
                        UnevenRoundedRectangle(
                            cornerRadii: .init(
                                topLeading: 45,
                                bottomLeading: 45,
                                bottomTrailing: 45,
                                topTrailing: 0
                            )
                        )
                        .fill(Color.overlayLight)
                    )
            }
            .frame(width: geo.size.width, height: geo.size.height)
            .background(Color.mainBlue)
        }
        VStack {
            Text("Login")
                .font(.myFont(style: .title, weight: .medium))
        }
        .background(Color.bgLight)
    }
}

#Preview {
    LoginView()
        .ignoresSafeArea()
}
