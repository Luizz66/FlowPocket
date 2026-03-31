//
//  RegisterView.swift
//  FlowPocket
//
//  Created by Luiz Gustavo Barros Campos on 26/03/26.
//

import SwiftUI

struct RegisterView: View {
    @State private var emailTxt: String = ""
    @State private var passwordTxt: String = ""
    @State private var confirmPasswordTxt: String = ""
    
    @State private var isValid: Bool = true
    
    @StateObject private var vm = AuthenticationViewModel(service: AuthenticationService())
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                registerTitle()
                VStack {
                    VStack(spacing: 20) {
                        inputsRegister()
                        btnRegister()
                        btnHasAccount()
                    }
                    .font(.myFont(style: .body, weight: .medium))
                    .padding(20)
                    .padding(.vertical)
                    .padding(.top, 45)
                }
                .background(Color.bgLight)
                .customClipShapeRounded()
            }
            .background(Color.mainBlue)
            .ignoresSafeArea()
        }
    }
    
    // MARK: - ViewBuilders
    @ViewBuilder
    func registerTitle() -> some View {
        Spacer()
        Text("Inscreva-se")
            .font(.myFont(style: .largeTitle, weight: .regular))
            .padding(.vertical, 50)
            .foregroundColor(.overlayLight)
    }
    
    @ViewBuilder
    func inputsRegister() -> some View {
        Group {
            VStack(alignment: .leading) {
                Text("Email")
                    .padding(.bottom, 6)
                customTxtField($emailTxt, fill: vm.fieldEmpty, prompt: "Digite seu e-mail")
                    .keyboardType(.emailAddress)
            }
            
            VStack(alignment: .leading) {
                Text("Senha")
                    .padding(.bottom, 6)
                customSecureField($passwordTxt, fill: vm.fieldEmpty, prompt: "Crie uma senha")
                    .textContentType(.password)
            }
            
            VStack(alignment: .leading) {
                Text("Confirme sua senha")
                    .padding(.bottom, 6)
                customSecureField($confirmPasswordTxt, fill: vm.fieldEmpty, prompt: "Crie uma senha")
                    .textContentType(.password)
            }
            
        }
        .textInputAutocapitalization(.never)
        .customInputStyle()
    }
    
    @ViewBuilder
    func btnRegister() -> some View {
        CustomBtn(txt: "Inscrever-se", colorTxt: .overlayLight, colorBtn: .mainBlue) {
            let fields = [emailTxt, passwordTxt, confirmPasswordTxt]
            if fields.allSatisfy({ !$0.isEmpty }) {
                if passwordTxt == confirmPasswordTxt {
                    vm.register(email: emailTxt, password: passwordTxt)
                    if vm.sucess == true {
                        print("✅Inscrição bem sucedida \(vm.sucessMessage)")
                    }
                } else {
                    vm.differentPassword()
                }
            } else {
                vm.fieldEmpty = true
            }
        }
        .padding(.top)
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
    func btnHasAccount() -> some View {
        Button("Já possui conta? Entre") {
            dismiss()
        }
        .foregroundColor(.black)
        .padding(.bottom, 60)
    }
}

#Preview {
    RegisterView()
}
