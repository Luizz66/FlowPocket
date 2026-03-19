//
//  LoginService.swift
//  FlowPocket
//
//  Created by Luiz Gustavo Barros Campos on 18/03/26.
//

import FirebaseAuth
import Combine

class LoginService {
    func register(email: String, password: String) async -> String {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            return "Usuário criado: \(result.user.uid)"
        } catch {
            return "Erro ao criar usuário: \(error.localizedDescription)"
        }
    }
    
    func login(email: String, password: String) async -> String {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            return "Logado: \(result.user.uid)"
        } catch {
            return "Erro ao logar: \(error.localizedDescription)"
        }
    }
    
    func logout() {
        try? Auth.auth().signOut()
    }
}
