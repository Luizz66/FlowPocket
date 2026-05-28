//
//  RootView.swift
//  FlowPocket
//
//  Created by Luiz Gustavo Barros Campos on 28/05/26.
//

import SwiftUI

struct RootView: View {
    @StateObject private var session = SessionViewModel()

    var body: some View {
        Group {
            if session.isLoggedIn {
                ContentTabView()
            } else {
                LoginView()
            }
        }
    }
}
