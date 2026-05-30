//
//  SessionViewModel.swift
//  FlowPocket
//
//  Created by Luiz Gustavo Barros Campos on 28/05/26.
//

import Foundation
import FirebaseAuth
import Combine

//Observa o Firebase
@MainActor
class SessionViewModel: ObservableObject {
    @Published var isLoggedIn = false
    @Published var isLoading = true
    
    @Published var isWaitingRegisterConfirmation = false
    
    private var authHandle: AuthStateDidChangeListenerHandle?
    
    init() {
        
        authHandle = Auth.auth().addStateDidChangeListener { _, user in
            
            if self.isWaitingRegisterConfirmation {
                return
            }
            
            guard let user = user else {
                self.isLoggedIn = false
                self.isLoading = false
                return
            }
            
            user.reload { error in
                if error != nil || Auth.auth().currentUser == nil {
                    try? Auth.auth().signOut()
                    
                    self.isLoggedIn = false
                } else {
                    self.isLoggedIn = true
                }
                
                self.isLoading = false
            }
        }
    }
    
    deinit {
        if let handle = authHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}
