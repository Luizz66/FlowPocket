//
//  LoginView.swift
//  FlowPocket
//
//  Created by Luiz Gustavo Barros Campos on 01/03/26.
//

import SwiftUI

struct LoginView: View {
    @State private var emailTxt: String = ""
    @State private var senhaTxt: String = ""
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Image("ImgIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.width / 3.4)
                    .clipShape(
                        UnevenRoundedRectangle(
                            cornerRadii: .init(
                                topLeading: 25,
                                bottomLeading: 0,
                                bottomTrailing: 25,
                                topTrailing: 25
                            )
                        )
                    )
                    .padding(27)
                    .background(
                        UnevenRoundedRectangle(
                            cornerRadii: .init(
                                topLeading: 35,
                                bottomLeading: 35,
                                bottomTrailing: 35,
                                topTrailing: 0
                            )
                        )
                        .fill(Color.overlayLight)
                    )
                    .padding(.top)
            }
            .frame(width: geo.size.width, height: geo.size.height)
            .background(Color.mainBlue)
        }
        VStack {
            Text("Login")
                .font(.myFont(style: .largeTitle, weight: .regular))
                .padding(.vertical, 30)
            VStack(spacing: 20) {
                VStack(alignment: .leading) {
                    Text("E-mail")
                        .padding(.bottom, 6)
                    TextField("exemplo@mail.com", text: $emailTxt)
                }
                .padding(10)
                .background(Color.overlayLight)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: .black.opacity(0.6), radius: 2, x: 1.5, y: 1.8)
                
                VStack(alignment: .leading) {
                    Text("Senha")
                        .padding(.bottom, 6)
                    TextField("........", text: $senhaTxt)
                }
                .padding(10)
                .background(Color.overlayLight)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: .black.opacity(0.6), radius: 2, x: 1.5, y: 1.8)
                
                Button { 
                    
                } label: {
                    Text("Login")
                        .font(.myFont(style: .title2, weight: .medium))
                        .foregroundColor(.overlayLight)
                        .shadow(color: .black.opacity(0.2), radius: 2, x: 1, y: 1.5)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 18)
                .background(Color.mainBlue)
                .clipShape(
                    UnevenRoundedRectangle(
                        cornerRadii: .init(
                            topLeading: 20,
                            bottomLeading: 20,
                            bottomTrailing: 20,
                            topTrailing: 0
                        )
                    )
                )
                .shadow(color: .black.opacity(0.6), radius: 2, x: 1.5, y: 1.8)
                .padding(.vertical, 25)
                
                Button("Não Possui Conta? Inscreva-se") {
                    
                }
                .foregroundColor(.black)
                .padding(.bottom)
            }
            .font(.myFont(style: .body, weight: .medium))
            .padding(20)
        }
        .background(Color.bgLight)
    }
}

#Preview {
    LoginView()
        .ignoresSafeArea()
}
