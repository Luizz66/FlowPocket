//
//  ResetPasswordSheetView.swift
//  FlowPocket
//
//  Created by Luiz Gustavo Barros Campos on 26/07/26.
//

import SwiftUI

struct ResetPasswordSheetView: View {
    @ObservedObject var vm: LoginViewModel
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            Text("Recuperação de senha")
                .font(.myFont(style: .title2, weight: .medium))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical)
            
            Text("Informe seu e-mail de cadastro. Se existir uma conta vinculada a ele, você receberá um link para redefinir sua senha.")
                .font(.myFont(style: .body, weight: .regular))
                .padding(.bottom)
            
            CustomTextField(
                text: $vm.resetEmailTxt,
                placeholder: "E-mail cadastrado",
                kind: .email,
                state: vm.resetEmailState
            )
            .padding(.vertical)
            
            Spacer()
            
            CustomBtn(txt: "Enviar", colorBtn: .mainBlue) {
                if vm.validateResetEmail() {
                    vm.resetPassword()
                }
            }
            .alert(vm.resetMessage, isPresented: $vm.resetShowAlert) {
                Button("OK", role: .cancel) {
                    if vm.resetSuccess == true {
                        isPresented = false
                    }
                }
            }
            
            CustomBtn(
                txt: "Voltar",
                colorTxt: .textPrimary,
                colorBtn: .customGray,
                tipTop: false
            ) {
                isPresented = false
            }
        }
        .onDisappear {
            vm.resetEmailState = .neutral
            vm.resetEmailTxt = ""
        }
        .padding(20)
        .presentationDetents([.large])
        .presentationDragIndicator(.visible)
    }
}

// MARK: - Preview
private struct ResetPasswordSheetView_PreviewContainer: View {
    @StateObject private var vm = LoginViewModel(service: AuthenticationService())
    @State private var isPresented: Bool = true
    
    var body: some View {
        ResetPasswordSheetView(vm: vm, isPresented: $isPresented)
    }
}

struct ResetPasswordSheetView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordSheetView_PreviewContainer()
    }
}
