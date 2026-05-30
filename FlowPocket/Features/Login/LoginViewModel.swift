//
//  LoginViewModel.swift
//  FlowPocket
//
//  Created by Luiz Gustavo Barros Campos on 28/05/26.
//

import Combine
import FirebaseAuth

@MainActor
class LoginViewModel: ObservableObject {
    @Published var errorMessage: String = ""
    
    @Published var sucess: Bool = false
    @Published var hasError: Bool = false
    
    private let service: AuthenticationService
    
    //Inputs
    @Published var emailTxt: String = ""
    @Published var passwordTxt: String = ""
    
    @Published var emailState: InputState = .neutral
    @Published var passwordState: InputState = .neutral
    
    init(service: AuthenticationService) {
        self.service = service
    }
    
    func login() {
        Task {
            do {
                let result = try await service.login(email: emailTxt, password: passwordTxt)
                
                self.sucess = true
                
                print("✅ Logado: \(result.user.uid)")
            } catch {
                if validateAll() == true {
                    self.hasError = true
                    self.errorMessage = """
                    Ops, algo deu errado ao logar :(
                    Confira as informações e tente novamente!
                    """
                }
                print("❌Erro ao logar: \(error), Descrição: \(error.localizedDescription)")
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
        
        return validate
    }
}
