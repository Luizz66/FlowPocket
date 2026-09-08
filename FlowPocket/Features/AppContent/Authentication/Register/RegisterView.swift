//
//  RegisterView.swift
//  FlowPocket
//
//  Created by Luiz Gustavo Barros Campos on 26/03/26.
//

import SwiftUI

struct RegisterView: View {
    @StateObject private var vm = RegisterViewModel(service: AuthenticationService())
    
    @EnvironmentObject private var session: SessionViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.mainBlue
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    registerTitleView()
                    
                    VStack {
                        VStack(spacing: 20) {
                            inputsRegisterView()
                            btnRegisterView()
                            btnHasAccountView()
                        }
                        .font(.myFont(style: .body, weight: .medium))
                        .padding(20)
                        .padding(.top, 65)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .safeAreaPadding(.bottom)
                    .background(Color.bg)
                    .customClipShapeRounded()
                }
            }
            .ignoresSafeArea()
        }
        .loadingOverlay(isLoading: vm.isLoading, message: "Criando conta...")
        .alert("Erro ao criar conta!", isPresented: $vm.registerError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(vm.resetErrorMessage)
        }
        .alert("Conta criada com sucesso!", isPresented: $vm.registerSuccess) {
            Button("Ir para o App") {
                session.isWaitingRegisterConfirmation = false
                session.isLoggedIn = true
            }
        } message: {
            Text("E-mail: \(vm.userEmail)")
        }
    }
    
    // MARK: - ViewBuilders
    @ViewBuilder
    func registerTitleView() -> some View {
        VStack {
            Text("Inscreva-se")
                .font(.myFont(style: .largeTitle, weight: .regular))
                .padding(.vertical)
                .foregroundColor(.white)
        }
        .padding(.top, 100)
        .padding(.vertical)
        .safeAreaPadding(.top)
    }
    
    @ViewBuilder
    func inputsRegisterView() -> some View {
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
        
        VStack(alignment: .leading) {
            CustomTextField(
                text: $vm.confirmPasswordTxt,
                placeholder: "Confirme sua senha",
                kind: .password(min: 6),
                state: vm.confirmPasswordState
            )
        }
    }
    
    @ViewBuilder
    func btnRegisterView() -> some View {
        CustomBtn(txt: "Inscrever-se", colorBtn: .mainBlue) {
            if vm.validateAll() {
                session.isWaitingRegisterConfirmation = true
                vm.register()
            }
        }
        .padding(.vertical, 20)
        .padding(.bottom, 5)
    }
    
    @ViewBuilder
    func btnHasAccountView() -> some View {
        TextBtn(txt: "Já possui conta? Entre") {
            dismiss()
        }
        .padding(.bottom, 60)
    }
}

// MARK: - Preview
struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
            .previewDisplayName("Register Light Mode")
            .preferredColorScheme(.light)
        
        RegisterView()
            .previewDisplayName("Register Dark Mode")
            .preferredColorScheme(.dark)
    }
}
