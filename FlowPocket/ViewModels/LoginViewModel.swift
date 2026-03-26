//
//  LoginViewModel.swift
//  FlowPocket
//
//  Created by Luiz Gustavo Barros Campos on 01/03/26.
//

import Combine
import FirebaseAuth

@MainActor
class LoginViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    
    @Published var sucessMessage: String = ""
    @Published var errorMessage: String = ""
    
    @Published var sucess: Bool = false
    @Published var hasError: Bool = false
    
    private let service: AuthenticationService
    
    init(service: AuthenticationService) {
        self.service = service
        
        if let user = Auth.auth().currentUser {
            isLoggedIn = true
            print("Usuário já logado:", user.uid)
        } else {
            print("Ninguém logado")
        }
    }
    
    func login(email: String, password: String) {
        Task {
            self.hasError = false
            self.sucess = false
            
            if !validateEmail(email) && !validadePassword(password) {
                self.hasError = true
                self.errorMessage = "E-mail e senha inválidos!"
                return
            }
            
            guard validateEmail(email) else {
                self.hasError = true
                self.errorMessage = "Favor inserir um e-mail válido!"
                return
            }
            
            guard validadePassword(password) else {
                self.hasError = true
                self.errorMessage = "A senha precisa ter pelo menos 6 caracteres!"
                return
            }
            
            do {
                let result = try await service.login(email: email, password: password)
                
                self.sucessMessage = "Logado: \(result.user.uid)"
                print("✅ Logado: \(result.user.uid)")
                self.sucess = true
                self.isLoggedIn = true
            } catch {
                self.hasError = true
                self.errorMessage = "Erro ao logar, verifique os dados e tente novamente!"
                print("❌ Erro: \(error.localizedDescription)")
                self.isLoggedIn = false
            }
        }
    }
    
    func register(email: String, password: String) {
        Task {
            if !validateEmail(email) && !validadePassword(password) {
                self.hasError = true
                self.errorMessage = "E-mail e senha inválidos!"
                return
            }
            
            guard validateEmail(email) else {
                self.hasError = true
                self.errorMessage = "Favor inserir um e-mail válido!"
                return
            }
            
            guard validadePassword(password) else {
                self.hasError = true
                self.errorMessage = "A senha precisa ter pelo menos 6 caracteres!"
                return
            }
            
            do {
                let result = try await service.register(email: email, password: password)
                
                self.sucessMessage = "Usário criado: \(result.user.uid)"
                print("✅ Usário criado: \(result.user.uid)")
                self.sucess = true
            } catch {
                self.hasError = true
                self.errorMessage = error.localizedDescription
                print("❌Erro: \(error.localizedDescription)")
            }
        }
    }
    
    private func validateEmail(_ email: String) -> Bool {
        return email.contains("@") && email.contains(".")
    }
    
    private func validadePassword(_ password: String) -> Bool {
        return password.count >= 6
    }
}
