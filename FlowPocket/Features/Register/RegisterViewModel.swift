//
//  RegisterViewModel.swift
//  FlowPocket
//
//  Created by Luiz Gustavo Barros Campos on 28/05/26.
//

import Combine
import FirebaseAuth

@MainActor
class RegisterViewModel: ObservableObject {
    @Published var sucessMessage: String = ""
    @Published var errorMessage: String = ""
    
    @Published var sucess: Bool = false
    @Published var hasError: Bool = false
    
    @Published var fieldEmpty: Bool?
    
    @Published var accountCreatedNow: Bool?
    
    private let service: AuthenticationService
    
    init(service: AuthenticationService) {
        self.service = service
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
                print("❌Erro: \(error)")
            }
        }
    }
    
    func differentPassword() {
        self.errorMessage = "Ops,as Senhas são diferentes, digite as mesmas senhas!"
    }
}
