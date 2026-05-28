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
    @Published var isLoggedIn: Bool = false
    
    @Published var sucessMessage: String = ""
    @Published var errorMessage: String = ""
    
    @Published var sucess: Bool = false
    @Published var hasError: Bool = false
    
    @Published var fieldEmpty: Bool?
    
    private let service: AuthenticationService
    private var authHandle: AuthStateDidChangeListenerHandle?
    
    init(service: AuthenticationService) {
        self.service = service
        
        authHandle = Auth.auth().addStateDidChangeListener { _, user in
            self.isLoggedIn = user != nil
            
            if let user = user {
                print("✅ Usuário logado: \(user.uid)")
            } else {
                print("❌ Usuário deslogado")
            }
        }
    }
    
    deinit {
        if let handle = authHandle {
            Auth.auth().removeStateDidChangeListener(handle)
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
            } catch {
                self.hasError = true
                self.errorMessage = "Erro ao logar, verifique os dados e tente novamente!"
                print("❌ Erro: \(error)")
            }
        }
    }
}
