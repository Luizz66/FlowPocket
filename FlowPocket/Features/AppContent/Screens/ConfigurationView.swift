//
//  ConfigurationView.swift
//  FlowPocket
//
//  Created by Luiz Gustavo Barros Campos on 30/03/26.
//

import SwiftUI

struct ConfigurationView: View {
    private let service = AuthenticationService()

    var body: some View {
        VStack {
            Text("Configuration")

            Button("Sair") {
                service.logout()
            }
            .padding()
        }
    }
}

#Preview {
    ConfigurationView()
}
