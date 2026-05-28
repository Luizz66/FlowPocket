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
    
    @State private var passWordState: InputState = .neutral
    @State private var emailState: InputState = .neutral
    
    @State private var isValid: Bool = false
    
    @StateObject private var vm = LoginViewModel(service: AuthenticationService())
    
    @State private var goRegister: Bool = false
    
    var body: some View {
        if vm.isLoggedIn {
            ContentTabView()
        } else {
            NavigationStack {
                VStack {
                    IconView()
                    VStack {
                        LoginTitleView()
                        VStack(spacing: 20) {
                            InputsLoginView()
                            BtnLoginView()
                            BtnRegisterView()
                        }
                        .font(.myFont(style: .body, weight: .medium))
                        .padding(20)
                    }
                    .background(Color.bg)
                    .customClipShapeRounded()
                }
                .background(Color.mainBlue)
                .ignoresSafeArea()
            }
        }
    }
    
    // MARK: - ViewBuilders
    @ViewBuilder
    func IconView() -> some View {
        GeometryReader { geo in
            VStack {
                Image("ImgIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.width / 3.7)
                    .clipShape(
                        UnevenRoundedRectangle(
                            cornerRadii: .init(
                                topLeading: 25,
                                bottomLeading: 25,
                                bottomTrailing: 25,
                                topTrailing: 0
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
                        .fill(Color.backdrop)
                    )
                    .padding(.top, 32)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
    }
    
    @ViewBuilder
    func LoginTitleView() -> some View {
        Spacer()
        Text("Login")
            .font(.myFont(style: .largeTitle, weight: .regular))
            .padding(.vertical, 35)
            .padding(.top)
    }
    
    @ViewBuilder
    func InputsLoginView() -> some View {
        Group {
            VStack(alignment: .leading) {
                CustomTextField(
                    text: $emailTxt,
                    placeholder: "E-mail",
                    kind: .email,
                    state: emailState
                )
            }
            
            VStack(alignment: .leading) {
                CustomTextField(
                    text: $passwordTxt,
                    placeholder: "Senha",
                    kind: .password(min: 6),
                    state: passWordState
                )
            }
        }
    }
    
    @ViewBuilder
    func BtnLoginView() -> some View {
        CustomBtn(txt: "Login", colorTxt: .backdrop, colorBtn: .mainBlue) {
            if emailTxt != "" && passwordTxt != "" {
                vm.login(email: emailTxt, password: passwordTxt)
                if vm.sucess == true {
                    print("✅Login bem sucedido \(vm.sucessMessage)")
                }
            } else {
                vm.fieldEmpty = true
            }
        }
        .padding(.vertical, 20)
        .padding(.bottom, 5)
        .alert("Erro", isPresented: $vm.hasError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(vm.errorMessage)
        }
    }
    
    @ViewBuilder
    func BtnRegisterView() -> some View {
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
