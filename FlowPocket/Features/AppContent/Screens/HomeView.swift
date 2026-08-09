//
//  HomeView.swift
//  FlowPocket
//
//  Created by Luiz Gustavo Barros Campos on 19/02/26.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Transaction.date, ascending: false)],
        animation: .default
    ) private var transactions: FetchedResults<Transaction>
    
    var body: some View {
        VStack {
            Text("Home")
            
            Text("Total de transações: \(transactions.count)")
        }
    }
}

// MARK: - Preview
struct HomeView_Preview: PreviewProvider {
    static let previewContext = CoreDataManager.shared.container.viewContext
    
    static var previews: some View {
        NavigationView {
            HomeView()
                .environment(\.managedObjectContext, previewContext)
        }
    }
}
