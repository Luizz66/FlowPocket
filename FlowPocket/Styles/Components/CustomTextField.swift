//
//  CustomTextField.swift
//  FlowPocket
//
//  Created by Luiz Gustavo Barros Campos on 22/05/26.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    let placeholder: String
    let kind: TextInputKind
    var state: InputState? = nil
    var inputDisable: Bool? = false
    
    @FocusState private var isFocused: Bool
    
    var isFloating: Bool {
        isFocused || !text.isEmpty
    }
    
    private let inputTextColorPrimary = Color(.textPrimary)
    private let inputTextColorSecondary = Color(.textSecondary)
    private let inputFillColor = Color(.backdrop)
    private let inputBorderColor = Color(.textPrimary)
    
    var body: some View {
        ZStack(alignment: .leading) {
            if placeholder != "" {
                txtPlaceHolder()
            }
            
            txtField()
                .modifier(BaseCustomTextField(kind: kind))
                .modifier(InputMaskModifier(kind: kind, text: $text))
        }
        .padding(8)
        .background(inputFillColor)
        .overlay(
            RoundedRectangle(cornerRadius: 9)
                .stroke(inputBorderColor, lineWidth: 2)
        )
        .cornerRadius(9)
        .disabled(inputDisable == true ? true : false)
        .modifier(InputDecorationModifier(state: state ?? .neutral))
        .transaction { $0.disablesAnimations = false }
    }
    
    // MARK: - ViewBuilders
    @ViewBuilder
    private func txtPlaceHolder() -> some View {
        Text(placeholder)
            .foregroundColor(inputTextColorSecondary)
            .font(.myFont(size: isFloating ? 16 : 18, weight: .regular))
            .offset(y: isFloating ? -22 : 0)
            .scaleEffect(isFloating ? 0.9 : 1.0, anchor: .leading)
            .animation(.easeInOut(duration: 0.3), value: isFloating)
            .padding(.top, isFloating ? 7 : 0)
            .background(inputFillColor)
    }
    
    @ViewBuilder
    private func txtField() -> some View {
        Group {
            if case .password = kind {
                SecureField("", text: $text)
            } else {
                TextField("", text: $text)
                    .foregroundColor(inputDisable == true ? inputTextColorSecondary : inputTextColorPrimary)
            }
        }
        .focused($isFocused)
        .padding(.top, placeholder != "" ? 6 : 0)
        .frame(height: 39)
    }
}

// MARK: - Previews
struct CustomTextField_AllPreviews: PreviewProvider {
    struct DemoView: View {
        @State private var email: String = ""
        @State private var date: String = ""
        @State private var password: String = ""
        @State private var name: String = ""
        @State private var freeText: String = ""
        @State private var cpf: String = "000.000.000-00"
        
        @State private var dateState: InputState = .neutral
        @State private var emailState: InputState = .neutral
        @State private var passWordState: InputState = .neutral
        @State private var nameState: InputState = .neutral
        
        var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 4) {
                        CustomTextField(text: $email, placeholder: "email@dominio.com", kind: .email, state: emailState)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        CustomTextField(text: $date, placeholder: "Data", kind: .date, state: dateState)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        CustomTextField(text: $password, placeholder: "Senha (mín. 6, alfanumérica)", kind: .password(min: 6), state: passWordState)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        CustomTextField(text: $name, placeholder: "Primeiro Nome", kind: .name, state: nameState)
                    }
                    
                    //Exemplo sem placeholder
                    VStack(alignment: .leading, spacing: 4) {
                        CustomTextField(text: $freeText, placeholder: "", kind: .freeText)
                    }
                    
                    //Exemplo Disable
                    VStack(alignment: .leading, spacing: 4) {
                        CustomTextField(text: $cpf, placeholder: "CPF", kind: .freeText, inputDisable: true)
                    }
                }
                .padding(.bottom, 32)
                
                CustomBtn(
                    txt: "Salvar",
                    colorTxt: .primary,
                    colorBtn: .mainBlue
                ) { validate() }
                
            }
            .padding()
        }
        
        // MARK: - validação exemplo
        private func validate() {
            if InputValidator.isValid(email, for: .email) {
                emailState = .neutral
            } else {
                emailState = .error(message: "Digite um E-mail válido. Ex: email@dominio.com")
            }
            
            if InputValidator.isValid(date, for: .date) {
                dateState = .neutral
            } else {
                dateState = .error(message: "Digite uma data valida. Ex: 00/00/0000")
            }
            
            if InputValidator.isValid(password, for: .password(min: 6)) {
                passWordState = .neutral
            } else {
                passWordState = .error(message: "A senha precisa ter no minímo 6 caracteres")
            }
            
            if InputValidator.isValid(name, for: .name) {
                nameState = .neutral
            } else {
                nameState = .error(message: "O nome precisa ter no minímo 2 caracteres")
            }
            
        }
    }
    
    static var previews: some View {
        Group {
            DemoView()
                .previewDisplayName("Custom Text Field Light")
                .background(Color(white: 0.95))
            
            DemoView()
                .previewDisplayName("Custom Text Field Dark")
                .preferredColorScheme(.dark)
                .background(Color.backdrop)
        }
    }
}
