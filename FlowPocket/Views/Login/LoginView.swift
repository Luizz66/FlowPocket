//
//  LoginView.swift
//  FlowPocket
//
//  Created by Luiz Gustavo Barros Campos on 01/03/26.
//

import SwiftUI

struct LoginView: View {
    @State private var emailTxt: String = ""
    @State private var passwordTxt: String = ""
    @State private var isValid: Bool = false
    
    @StateObject private var vm = AuthenticationViewModel(service: AuthenticationService())
    
    @State private var goRegister: Bool = false
    
    var body: some View {
        if vm.isLoggedIn {
            ContentTabView()
        } else {
            NavigationStack {
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
            }
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
                customTxtField($emailTxt, fill: vm.fieldEmpty, prompt: "Digite seu e-mail")
                    .keyboardType(.emailAddress)
            }
            
            VStack(alignment: .leading) {
                Text("Senha")
                    .padding(.bottom, 6)
                customSecureField($passwordTxt, fill: vm.fieldEmpty, prompt: "Digite sua senha")
            }
        }
        .customInputStyle()
        .textInputAutocapitalization(.never)
    }
    
    @ViewBuilder
    func btnLogin() -> some View {
        CustomBtn(txt: "Login", colorTxt: .overlayLight, colorBtn: .mainBlue) {
            if emailTxt != "" && passwordTxt != "" {
                vm.login(email: emailTxt, password: passwordTxt)
                if vm.sucess == true {
                    print("✅Login bem sucedido \(vm.sucessMessage)")
                }
            } else {
                vm.fieldEmpty = true
            }
        }
        .alert("Erro", isPresented: $vm.hasError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(vm.errorMessage)
        }
        .navigationDestination(isPresented: $vm.sucess) {
            ContentTabView()
        }
    }
    
    @ViewBuilder
    func btnRegister() -> some View {
        Button("Não Possui Conta? Inscreva-se") {
            goRegister = true
        }
        .foregroundColor(.black)
        .padding(.bottom, 40)
        .navigationDestination(isPresented: $goRegister) {
            RegisterView()
        }
    }
}

#Preview {
    LoginView()
}
