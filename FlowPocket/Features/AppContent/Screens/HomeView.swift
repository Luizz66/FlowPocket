//
//  HomeView.swift
//  FlowPocket
//
//  Created by Luiz Gustavo Barros Campos on 19/02/26.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @EnvironmentObject private var transactionsStore: TransactionsStore
    
    var body: some View {
        VStack {
            Text("Home")
            
            Text("Total de transações: \(transactionsStore.transactions.count)")
        }
    }
}

// MARK: - Preview
struct HomeView_Preview: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .environmentObject(
                    TransactionsStore(
                        context: CoreDataManager.shared.container.viewContext
                    )
                )
        }
    }
}
