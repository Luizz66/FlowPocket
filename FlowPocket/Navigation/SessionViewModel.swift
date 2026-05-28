//
//  SessionViewModel.swift
//  FlowPocket
//
//  Created by Luiz Gustavo Barros Campos on 28/05/26.
//

import Foundation
import FirebaseAuth
import Combine

@MainActor
class SessionViewModel: ObservableObject {
    @Published var isLoggedIn = false

    private var authHandle: AuthStateDidChangeListenerHandle?

    init() {
        authHandle = Auth.auth().addStateDidChangeListener { _, user in
            self.isLoggedIn = user != nil
        }
    }

    deinit {
        if let handle = authHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}
