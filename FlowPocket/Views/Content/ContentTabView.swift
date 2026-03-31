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
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                }
            
            TransactionView()
                .tabItem {
                    Image(systemName: "arrow.left.arrow.right")
                }
            
            AddNewTransactionView()
                .tabItem {
                    Image(systemName: "plus.app.fill")
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
    }
}

struct ContentTabView_Preview: PreviewProvider {
    static let previewContext = CoreDataManager.shared.container.viewContext
    
    static var previews: some View {
        NavigationView { 
            ContentTabView()
                .environment(\.managedObjectContext, previewContext)            
        }
    }
}
