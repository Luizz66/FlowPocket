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
    
    @State private var emailState: InputState = .neutral
    @State private var passwordState: InputState = .neutral
    @State private var confirmPasswordState: InputState = .neutral
    
    @State private var isValid: Bool = true
    
    @StateObject private var vm = RegisterViewModel(service: AuthenticationService())
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                RegisterTitleView()
                VStack {
                    VStack(spacing: 20) {
                        InputsRegisterView()
                        BtnRegisterView()
                        BtnHasAccountView()
                    }
                    .font(.myFont(style: .body, weight: .medium))
                    .padding(20)
                    .padding(.vertical)
                    .padding(.top, 45)
                }
                .background(Color.bg)
                .customClipShapeRounded()
            }
            .background(Color.mainBlue)
            .ignoresSafeArea()
        }
    }
    
    // MARK: - ViewBuilders
    @ViewBuilder
    func RegisterTitleView() -> some View {
        Spacer()
        Text("Inscreva-se")
            .font(.myFont(style: .largeTitle, weight: .regular))
            .padding(.vertical, 50)
            .foregroundColor(.backdrop)
        Spacer()
    }
    
    @ViewBuilder
    func InputsRegisterView() -> some View {
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
                    state: passwordState
                )
            }
            
            VStack(alignment: .leading) {
                CustomTextField(
                    text: $confirmPasswordTxt,
                    placeholder: "Confirme sua senha",
                    kind: .password(min: 6),
                    state: confirmPasswordState
                )
            }
            
        }
        .textInputAutocapitalization(.never)
    }
    
    @ViewBuilder
    func BtnRegisterView() -> some View {
        CustomBtn(txt: "Inscrever-se", colorTxt: .backdrop, colorBtn: .mainBlue) {
            let fields = [emailTxt, passwordTxt, confirmPasswordTxt]
            if fields.allSatisfy({ !$0.isEmpty }) {
                if passwordTxt == confirmPasswordTxt {
                    vm.register(email: emailTxt, password: passwordTxt)
                    if vm.sucess == true {
                        vm.accountCreatedNow = true
                        print("✅Inscrição bem sucedida \(vm.sucessMessage)")
                    }
                } else {
                    vm.differentPassword()
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
    func BtnHasAccountView() -> some View {
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
