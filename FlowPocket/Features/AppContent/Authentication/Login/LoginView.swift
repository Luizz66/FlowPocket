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
            ZStack {
                Color.mainBlue
                    .ignoresSafeArea()
                
                VStack {
                    iconView()
                        .opacity(goResetPassword ? 0 : 1)
                        .animation(
                            goResetPassword
                            ? .easeOut(duration: 0.9)
                                : nil,
                            value: goResetPassword
                        )
                    VStack {
                        loginTitleView()
                        VStack(spacing: 20) {
                            inputsLoginView()
                            Spacer()
                            btnsStackView()
                            btnRegisterView()
                        }
                        .font(.myFont(style: .body, weight: .medium))
                        .padding(20)
                    }
                    .safeAreaPadding(.bottom)
                    .background(Color.bg)
                    .customClipShapeRounded()
                }
            }
            .ignoresSafeArea(edges: .bottom)
            .onAppear {
                vm.clearStates()
            }
        }
        .loadingOverlay(isLoading: vm.isLoadingLogin, message: "Carregando...")
        .alert("Erro ao logar!", isPresented: $vm.loginError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(vm.loginErrorMessage)
        }
    }
    
    // MARK: - ViewBuilders
    @ViewBuilder
    private func iconView() -> some View {
        let iconWidth = UIScreen.main.bounds.width / 3.9
        
        VStack {
            Image("ImgIcon")
                .resizable()
                .scaledToFit()
                .frame(width: iconWidth)
                .clipShape(
                    UnevenRoundedRectangle(
                        cornerRadii: .init(
                            topLeading: 25,
                            bottomLeading: 25,
                            bottomTrailing: 25,
                            topTrailing: 3
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
                            topTrailing: 3
                        )
                    )
                    .fill(Color.bg)
                )
                .safeAreaPadding(.top)
                .padding(.bottom)
        }
        .padding()
    }
    
    @ViewBuilder
    private func loginTitleView() -> some View {
        Spacer()
        Text("Login")
            .font(.myFont(style: .largeTitle, weight: .regular))
            .padding(.vertical)
            .padding(.top)
    }
    
    @ViewBuilder
    private func inputsLoginView() -> some View {
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
    private func btnsStackView() -> some View {
        VStack(spacing: 10) {
            btnLoginView()
            btnForgotPassword()
        }
    }
    
    @ViewBuilder
    private func btnLoginView() -> some View {
        CustomBtn(
            txt: "Login",
            colorBtn: .mainBlue
        ) {
            if vm.validateAll() {
                vm.login()
            }
        }
        .padding(.top, 20)
    }
    
    @ViewBuilder
    private func btnForgotPassword() -> some View {
        CustomBtn(
            txt: "Esqueci minha senha",
            colorTxt: .textPrimary,
            colorBtn: .customGray,
            tipTop: false
        ) {
            goResetPassword = true
            vm.clearStates()
        }
        .padding(.bottom, 24)
        .sheet(isPresented: $goResetPassword) {
            VStack {
                ResetPasswordSheetView(vm: vm, isPresented: $goResetPassword)
            }
        }
    }
    
    @ViewBuilder
    private func btnRegisterView() -> some View {
        TextBtn(txt: "Não Possui Conta? Inscreva-se") {
            goRegister = true
        }
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
