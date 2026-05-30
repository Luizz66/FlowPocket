//
//  RegisterViewModel.swift
//  FlowPocket
//
//  Created by Luiz Gustavo Barros Campos on 28/05/26.
//

import Combine
import FirebaseAuth
import SwiftUI

@MainActor
class RegisterViewModel: ObservableObject {
    @Published var errorMessage: String = ""
    
    @Published var sucess: Bool = false
    @Published var hasError: Bool = false
    
    private let service: AuthenticationService
    
    //Inputs
    @Published var emailTxt: String = ""
    @Published var passwordTxt: String = ""
    @Published var confirmPasswordTxt: String = ""
    
    @Published var emailState: InputState = .neutral
    @Published var passwordState: InputState = .neutral
    @Published var confirmPasswordState: InputState = .neutral
    
    init(service: AuthenticationService) {
        self.service = service
    }
    
    func register() {
        Task {
            do {
                let result = try await service.register(email: emailTxt, password: passwordTxt)
                
                self.sucess = true
                
                print("✅ Usário criado com sucesso, ID: \(result.user.uid)")
            } catch {
                if validateAll() {
                    self.hasError = true
                    self.errorMessage = """
                    Ops, algo deu errado ao criar o usuário :(
                    Confira as informações e tente novamente!
                    """
                }
                
                print("❌Erro ao criar conta: \(error), Descrição: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Validations
    func validateAll() -> Bool {
        var validate = false
        
        if InputValidator.isValid(emailTxt, for: .email) {
            validate = true
            emailState = .neutral
        } else {
            validate = false
            emailState = .error(message: "Informe um E-mail válido. Ex: email@dominio.com")
        }
        
        if InputValidator.isValid(passwordTxt, for: .password(min: 6)) {
            validate = true
            passwordState = .neutral
        } else {
            validate = false
            passwordState = .error(message: "A senha deve ter no minímo 6 caracteres")
        }
        
        if passwordTxt == confirmPasswordTxt {
            if InputValidator.isValid(confirmPasswordTxt, for: .password(min: 6)) {
                validate = true
                confirmPasswordState = .neutral
            } else {
                validate = false
                confirmPasswordState = .error(message: "A senha precisa ter no minímo 6 caracteres")
            }
        } else {
            validate = false
            confirmPasswordState = .error(message: "Senhas diferentes, digite a mesma senha em ambos os campos")
        }
        
        return validate
    }
}
