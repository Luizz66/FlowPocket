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
    
    @State private var isValid: Bool = true
    
    @StateObject private var vm = LoginViewModel(service: AuthenticationService())
    
    var body: some View {
        VStack {
            iconView()
            VStack {
                loginTitle()
                VStack(spacing: 20) {
                    inputsLogin()
                    btnLogin()
                    btnRegister()
                }
                .font(.myFont(style: .body, weight: .medium))
                .padding(20)
            }
            .background(Color.bgLight)
            .customClipShapeRounded()
        }
        .background(Color.mainBlue)
        .ignoresSafeArea()
        .navigationDestination(isPresented: $vm.sucess) {
            ContentTabView()
        }
    }
    
    // MARK: - ViewBuilders
    @ViewBuilder
    func iconView() -> some View {
        GeometryReader { geo in
            VStack {
                Image("ImgIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.width / 3.5)
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
                    .padding(28)
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
                    .padding(.top, 32)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
    }
    
    @ViewBuilder
    func loginTitle() -> some View {
        Spacer()
        Text("Login")
            .font(.myFont(style: .largeTitle, weight: .regular))
            .padding(.vertical, 35)
            .padding(.top)
    }
    
    @ViewBuilder
    func inputsLogin() -> some View {
        Group {
            VStack(alignment: .leading) {
                Text("E-mail")
                    .padding(.bottom, 6)
                TextField("Digite seu e-mail", text: $emailTxt)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
            }
            
            VStack(alignment: .leading) {
                Text("Senha")
                    .padding(.bottom, 6)
                SecureField("Digite sua senha", text: $senhaTxt)
            }
        }
        .padding(10)
        .background(Color.overlayLight)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: .black.opacity(0.6), radius: 2, x: 1.5, y: 1.8)
    }
    
    @ViewBuilder
    func btnLogin() -> some View {
        CustomBtn(txt: "Login", colorTxt: .overlayLight, colorBtn: .mainBlue) {
            if emailTxt != "" && senhaTxt != "" {
                vm.login(email: emailTxt, password: senhaTxt)
            }
        }
        .alert("Erro", isPresented: $vm.hasError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(vm.errorMessage)
        }
        .alert("Sucesso", isPresented: $vm.sucess) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(vm.sucessMessage)
        }
    }
    
    @ViewBuilder
    func btnRegister() -> some View {
        Button("Não Possui Conta? Inscreva-se") {
            
        }
        .foregroundColor(.black)
        .padding(.bottom, 40)
    }
}

#Preview {
    LoginView()
}
