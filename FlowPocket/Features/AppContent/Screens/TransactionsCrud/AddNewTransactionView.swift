//
//  AddNewTransactionView.swift
//  FlowPocket
//
//  Created by Luiz Gustavo Barros Campos on 30/03/26.
//

import SwiftUI
import CoreData

struct AddNewTransactionView: View {
    @EnvironmentObject private var transactionsStore: TransactionsStore
    
    var body: some View {
        VStack {
            Text("Add nova transação")
            
            List(transactionsStore.transactions.prefix(5)) { trans in
                Text(trans.name ?? "Sem nome")
            }
        }
    }
}

// MARK: - Preview
struct AddNewTransactionView_Preview: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddNewTransactionView()
                .environmentObject(
                    TransactionsStore(
                        context: CoreDataManager.shared.container.viewContext
                    )
                )
        }
    }
}
