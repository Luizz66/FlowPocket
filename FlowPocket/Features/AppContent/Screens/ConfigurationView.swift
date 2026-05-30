//
//  ConfigurationView.swift
//  FlowPocket
//
//  Created by Luiz Gustavo Barros Campos on 30/03/26.
//

import SwiftUI

struct ConfigurationView: View {
    private let service = AuthenticationService()
    
    @State private var showLogout: Bool = false

    var body: some View {
        VStack {
            Text("Configuration")
            
            Button("Sair") {
                showLogout = true
            }
            .alert("Tem certeza que deseja sair da conta?", isPresented: $showLogout) {
                Button("Cancelar", role: .cancel) { }
                Button("Sair", role: .destructive) {
                    service.logout()
                }
            } message: {
                Text("Você precisará fazer login novamente para acessar o app.")
            }
            .padding()
        }
    }
}

#Preview {
    ConfigurationView()
}
