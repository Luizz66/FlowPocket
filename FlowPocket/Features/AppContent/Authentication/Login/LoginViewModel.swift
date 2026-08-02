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
    @Published var loginErrorMessage: String = ""
    @Published var resetMessage: String = ""
    
    @Published var loginSuccess: Bool = false
    @Published var loginError: Bool = false
    
    @Published var resetSuccess: Bool = false
    @Published var resetShowAlert: Bool = false
    
    @Published var isLoadingLogin: Bool = false
    @Published var isLoadingReset: Bool = false
    
    private let service: AuthenticationService
    
    @Published var emailTxt: String = ""
    @Published var passwordTxt: String = ""
    @Published var resetEmailTxt: String = ""
    
    @Published var emailState: InputState = .neutral
    @Published var passwordState: InputState = .neutral
    @Published var resetEmailState: InputState = .neutral
    
    init(service: AuthenticationService) {
        self.service = service
    }
    
    func login() {
        Task {
            isLoadingLogin = true
            
            do {
                let result = try await service.login(email: emailTxt, password: passwordTxt)
                
                self.loginSuccess = true
                
                print("✅ Logado: \(result.user.uid)")
            } catch {
                let nsError = error as NSError
                let authErrorCode = AuthErrorCode(rawValue: nsError.code)
                let msg = """
                    Ops, algo deu errado ao logar.
                    
                    Confira as informações e tente novamente!
                    """
                
                switch authErrorCode {
                case .networkError:
                    loginErrorMessage = "Sem conexão com a internet."
                case .invalidCredential:
                    loginErrorMessage = "E-mail ou senha incorretos."
                default:
                    loginErrorMessage = msg
                }
                
                isLoadingLogin = false
                loginError = true
                
                print("❌ Erro ao logar: \(error), Descrição: \(error.localizedDescription)")
                return
            }
            
            isLoadingLogin = false
        }
    }
    
    func resetPassword() {
        Task {
            isLoadingReset = true
            
            do {
                try await service.resetPassword(email: resetEmailTxt)
                
                self.resetMessage = """
                E-mail enviado
                
                Se existir uma conta associada a este endereço,
                você receberá instruções para redefinir sua senha.
                """
                self.resetSuccess = true
            } catch {
                self.resetSuccess = false
                if validateResetEmail() == true {
                    self.resetMessage = """
                    Algo deu errado!!
                    
                    Não foi possível enviar o e-mail de redefinição.
                    """
                }
                print("❌ Erro ao resetar senha: \(error), Descrição: \(error.localizedDescription)")
            }
            
            isLoadingReset = false
            resetShowAlert = true
        }
    }
    
    // MARK: - Validations
    private let emailMessage = "Informe um E-mail válido. Ex: email@dominio.com"
    
    func validateResetEmail() -> Bool {
        if InputValidator.isValid(resetEmailTxt, for: .email) {
            resetEmailState = .neutral
            return true
        } else {
            resetEmailState = .error(message: emailMessage)
            return false
        }
    }
    
    func validateAll() -> Bool {
        var validate = false
        
        if InputValidator.isValid(emailTxt, for: .email) {
            validate = true
            emailState = .neutral
        } else {
            validate = false
            emailState = .error(message: emailMessage)
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
    
    // MARK: - Helpers
    func clearStates() {
        emailState = .neutral
        passwordState = .neutral
        resetEmailState = .neutral
    }
}
