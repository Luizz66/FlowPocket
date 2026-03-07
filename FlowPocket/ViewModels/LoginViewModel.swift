//
//  LoginViewModel.swift
//  FlowPocket
//
//  Created by Luiz Gustavo Barros Campos on 01/03/26.
//

import FirebaseAuth
import Combine

class LoginViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    
    init() {
        if let user = Auth.auth().currentUser {
            isLoggedIn = true
            print("Usuário já logado:", user.uid)
        } else {
            print("Ninguém logado")
        }
    }
    
    func register(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Erro: \(error.localizedDescription)")
                return
            }
            print("Usuário criado:", result?.user.uid ?? "")
        }
    }
    
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Erro no login:", error.localizedDescription)
                return
            }
            print("Logado:", result?.user.uid ?? "")
        }
    }
    
    func logout() {
        try? Auth.auth().signOut()
    }
    
    // MARK: - validations
    private func validateEmail(_ email: String) -> Bool {
        return email.contains("@")
    }
}
