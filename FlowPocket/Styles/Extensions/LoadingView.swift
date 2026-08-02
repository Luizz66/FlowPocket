//
//  LoadingView.swift
//  FlowPocket
//
//  Created by Luiz Gustavo Barros Campos on 01/08/26.
//

import SwiftUI

private struct LoadingView: View {
    var message: String? = nil
    
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.45)
            
            VStack(spacing: 18) {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.5)
                
                if let message {
                    Text(message)
                        .foregroundColor(.white)
                        .font(.myFont(style: .body, weight: .regular))
                }
            }
            .padding(24)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color.black.opacity(0.6))
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        /// Bloqueia qualquer toque na tela por trás (botões, textfields, etc)
        .contentShape(Rectangle())
        .allowsHitTesting(true)
        .transition(.opacity)
    }
}

// MARK: - Modifier de conveniência
private struct LoadingOverlayModifier: ViewModifier {
    let isLoading: Bool
    var message: String? = nil
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(isLoading) /// desabilita interação da hierarquia por trás

            if isLoading {
                LoadingView(message: message)
                    .zIndex(1)
            }
        }
    }
}

extension View {
    func loadingOverlay(isLoading: Bool, message: String? = nil) -> some View {
        modifier(LoadingOverlayModifier(isLoading: isLoading, message: message))
    }
}

// MARK: - LoadingOverlay para usar como view isolada
struct LoadingOverlayView: View {
    var body: some View {
        ZStack {
            Color.bg
                .ignoresSafeArea()
            
            LoadingView(message: "Carregando...")
        }
    }
}

// MARK: - Preview
private struct LoadingOverlayPreview_Container: View {
    @State private var isLoading = true
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Conteúdo da tela")
                .font(.title)
            
            Button("Ação qualquer") { }
                .buttonStyle(.borderedProminent)
            
            Toggle("Alternar loading", isOn: $isLoading)
                .padding(.horizontal, 40)
        }
        .padding()
        .loadingOverlay(isLoading: isLoading, message: "Carregando...")
    }
}

#Preview("Light Mode") {
    LoadingOverlayPreview_Container()
        .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    LoadingOverlayPreview_Container()
        .preferredColorScheme(.dark)
}
