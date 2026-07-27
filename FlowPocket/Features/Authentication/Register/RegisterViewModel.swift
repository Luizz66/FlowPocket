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
    @Published var resetErrorMessage: String = ""
    
    @Published var registerSuccess: Bool = false
    @Published var registerError: Bool = false
    
    private let service: AuthenticationService
    
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
                
                self.registerSuccess = true
                
                print("✅ Usário criado com sucesso, ID: \(result.user.uid)")
            } catch {
                let nsError = error as NSError
                let authErrorCode = AuthErrorCode(rawValue: nsError.code)
                let msg = """
                    Ops, algo deu errado ao criar o usuário.
                    
                    Confira as informações e tente novamente!
                    """
                
                switch authErrorCode {
                case .networkError:
                    resetErrorMessage = "Sem conexão com a internet."
                    registerError = true
                default:
                    resetErrorMessage = msg
                    registerError = true
                }
                
                if validateAll() == true {
                    self.registerError = true
                    self.resetErrorMessage = msg
                }
                
                print("❌Erro ao criar conta: \(error), Descrição: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Validations
    private let passwordMessage = "A senha deve ter no minímo 6 caracteres"
    
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
            passwordState = .error(message: passwordMessage)
        }
        
        if passwordTxt == confirmPasswordTxt {
            if InputValidator.isValid(confirmPasswordTxt, for: .password(min: 6)) {
                validate = true
                confirmPasswordState = .neutral
            } else {
                validate = false
                confirmPasswordState = .error(message: passwordMessage)
            }
        } else {
            validate = false
            confirmPasswordState = .error(message: "Senhas diferentes, digite a mesma senha em ambos os campos")
        }
        
        return validate
    }
}
