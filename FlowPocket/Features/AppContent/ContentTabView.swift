//
//  ContentTabView.swift
//  FlowPocket
//
//  Created by Luiz Gustavo Barros Campos on 01/03/26.
//

import SwiftUI
import CoreData

struct ContentTabView: View {
    
    var body: some View {
        TabView {
            Group {
                HomeView()
                    .tabItem {
                        Image(systemName: "house")
                    }
                
                TransactionsView()
                    .tabItem {
                        Image(systemName: "arrow.left.arrow.right")
                    }
                
                ChartsView()
                    .tabItem {
                        Image(systemName: "chart.bar.fill")
                    }
                
                ConfigurationView()
                    .tabItem {
                        Image(systemName: "gearshape.fill")
                    }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.bg)
        }
    }
}

// MARK: - Preview
private struct ContentTabView_PreviewContainer: View {
    var body: some View {
        ContentTabView()
            .environmentObject(
                TransactionsStore(
                    context: CoreDataManager.shared.container.viewContext
                )
            )
    }
}

#Preview("Light Mode") {
    ContentTabView_PreviewContainer()
        .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    ContentTabView_PreviewContainer()
        .preferredColorScheme(.dark)
}
