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
        sortDescriptors: [NSSortDescriptor(keyPath: \Transaction.date, ascending: true)],
        animation: .default
    ) private var transactions: FetchedResults<Transaction>

    var body: some View {
        NavigationView {
            List {
                ForEach(transactions) { trans in
                    NavigationLink {
                        Text("Adicionado em: \(trans.date!, formatter: itemFormatter)")
                        Text("Name: \(trans.name!)")
                        Text("Tipo: \(trans.type!)")
                        Text("Valor: \(trans.value!)")
                        Text("Categoria: \(trans.category!)")
                    } label: {
                        Text(trans.date!, formatter: itemFormatter)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Transaction(context: viewContext)
            newItem.date = Date()
            newItem.name = "Teste"
            newItem.type = "Gasto"
            newItem.value = NSDecimalNumber(decimal: Decimal(50.00))
            newItem.category = "Mercado"

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { transactions[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct HomeView_Preview: PreviewProvider {
    static let previewContext = CoreDataManager.shared.container.viewContext
    
    static var previews: some View {
        NavigationView { 
            HomeView()
                .environment(\.managedObjectContext, previewContext)            
        }
    }
}
