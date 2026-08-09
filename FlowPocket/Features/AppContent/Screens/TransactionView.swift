//
//  TransactionView.swift
//  FlowPocket
//
//  Created by Luiz Gustavo Barros Campos on 30/03/26.
//

import SwiftUI
import CoreData

struct TransactionView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Transaction.date, ascending: false)],
        animation: .default
    ) private var transactions: FetchedResults<Transaction>
    
    var body: some View {
        VStack {
            Text("Minhas transações")
            
            List(transactions.prefix(5)) { trans in
                Text(trans.name ?? "Sem nome")
            }
        }
    }
}

// MARK: - Preview
struct TransactionView_Preview: PreviewProvider {
    static let previewContext = CoreDataManager.shared.container.viewContext
    
    static var previews: some View {
        NavigationView {
            HomeView()
                .environment(\.managedObjectContext, previewContext)
        }
    }
}
