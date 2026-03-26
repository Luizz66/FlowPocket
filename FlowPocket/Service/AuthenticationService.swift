//
//  AuthenticationService.swift
//  FlowPocket
//
//  Created by Luiz Gustavo Barros Campos on 18/03/26.
//

import FirebaseAuth
import Combine

class AuthenticationService {
    func login(email: String, password: String) async throws -> AuthDataResult {
        return try await Auth.auth().signIn(withEmail: email, password: password)
    }
    
    func register(email: String, password: String) async throws -> AuthDataResult {
        return try await Auth.auth().createUser(withEmail: email, password: password)
    }
    
    func logout() {
        try? Auth.auth().signOut()
    }
}
