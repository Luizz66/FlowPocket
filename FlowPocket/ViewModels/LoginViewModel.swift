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
    @Published var message: String = ""
    
    private let service: LoginService
    
    init(service: LoginService) {
        self.service = service
        
        if let user = Auth.auth().currentUser {
            isLoggedIn = true
            print("Usuário já logado:", user.uid)
        } else {
            print("Ninguém logado")
        }
    }
    
    func register(email: String, password: String) {
        Task {
            if validateEmail(email) {
                let result = await service.register(email: email, password: password)
                self.message = result
            } else {
                self.message = "Favor inserir um e-mail válido!"
            }
        }
    }
    
    func login(email: String, password: String) {
        Task {
            if validateEmail(email) {
                let result = await service.login(email: email, password: password)
                self.message = result
                self.isLoggedIn = true
            } else {
                self.message = "E-mail ou senha incorretos!"
            }
        }
    }
    
    private func validateEmail(_ email: String) -> Bool {
        return email.contains("@") && email.contains(".")
    }
}
