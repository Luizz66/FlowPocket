//
//  LoginView.swift
//  FlowPocket
//
//  Created by Luiz Gustavo Barros Campos on 01/03/26.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var vm = LoginViewModel(service: AuthenticationService())
    
    @State private var goRegister: Bool = false
    @State private var goResetPassword: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                IconView()
                VStack {
                    LoginTitleView()
                    VStack(spacing: 20) {
                        InputsLoginView()
                        BtnsStack()
                        BtnRegisterView()
                    }
                    .font(.myFont(style: .body, weight: .medium))
                    .padding(20)
                }
                .padding(.bottom, 25)
                .background(Color.bg)
                .customClipShapeRounded()
            }
            .background(Color.mainBlue)
            .ignoresSafeArea()
        }
    }
    
    // MARK: - ViewBuilders
    @ViewBuilder
    private func IconView() -> some View {
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
                    .padding(20)
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
                    .padding(.top)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
    }
    
    @ViewBuilder
    private func LoginTitleView() -> some View {
        Spacer()
        Text("Login")
            .font(.myFont(style: .largeTitle, weight: .regular))
            .padding(.vertical)
            .padding(.top)
    }
    
    @ViewBuilder
    private func InputsLoginView() -> some View {
        VStack(alignment: .leading) {
            CustomTextField(
                text: $vm.emailTxt,
                placeholder: "E-mail",
                kind: .email,
                state: vm.emailState
            )
        }
        
        VStack(alignment: .leading) {
            CustomTextField(
                text: $vm.passwordTxt,
                placeholder: "Senha",
                kind: .password(min: 6),
                state: vm.passwordState
            )
        }
    }
    
    @ViewBuilder
    private func BtnsStack() -> some View {
        VStack(spacing: 0) {
            BtnLoginView()
            BtnForgotPassword()
        }
    }
    
    @ViewBuilder
    private func BtnLoginView() -> some View {
        CustomBtn(txt: "Login", colorBtn: .mainBlue) {
            if vm.validateAll() {
                vm.login()
            }
        }
        .padding(.top, 20)
        .padding(.bottom, 10)
        .alert("Erro ao logar!", isPresented: $vm.hasError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(vm.errorMessage)
        }
    }
    
    @ViewBuilder
    private func BtnForgotPassword() -> some View {
        CustomBtn(
            txt: "Esqueci minha senha",
            colorTxt: .textPrimary,
            colorBtn: .customGray,
            tipTop: false
        ) {
            goResetPassword = true
        }
        .padding(.bottom, 24)
        .navigationDestination(isPresented: $goResetPassword) {
            //
        }
    }
    
    @ViewBuilder
    private func BtnRegisterView() -> some View {
        Button("Não Possui Conta? Inscreva-se") {
            goRegister = true
        }
        .foregroundColor(.textPrimary)
        .padding(.bottom, 30)
        .navigationDestination(isPresented: $goRegister) {
            RegisterView()
        }
    }
}

// MARK: - Preview
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .previewDisplayName("Login Light Mode")
            .preferredColorScheme(.light)
        
        LoginView()
            .previewDisplayName("Login Dark Mode")
            .preferredColorScheme(.dark)
    }
}
