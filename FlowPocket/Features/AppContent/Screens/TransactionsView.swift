//
//  TransactionsView.swift
//  FlowPocket
//
//  Created by Luiz Gustavo Barros Campos on 30/03/26.
//

import SwiftUI
import CoreData

struct TransactionsView: View {
    @EnvironmentObject private var transactionsStore: TransactionsStore

    @State private var editMode: Bool = false
    @State private var goEdit: Bool = false
    @State private var goAdd: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(transactionsStore.transactions) { transaction in
                    transactionDetails(transaction)
                }
                .onDelete(perform: deleteItems)

            }
            .scrollContentBackground(.hidden)
            .background(Color.bg)
            .animation(.easeInOut(duration: 0.2), value: transactionsStore.transactions.count)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    editButton()
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    addButton()
                }
            }
        }
        .sheet(isPresented: $goEdit) {
            NavigationStack {
                EditTransaction()
                    .navigationTitle("Editar transação")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
        .sheet(isPresented: $goAdd) {
            NavigationStack {
                AddNewTransactionView()
                    .navigationTitle("Adicionar nova transação")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }

    // MARK: - View Builders
    @ViewBuilder
    private func editButton() -> some View {
        if editMode {
            Button {
                editMode.toggle()
            } label: {
                Image(systemName: "checkmark")
            }
            .buttonStyle(.borderedProminent)
        } else {
            Button {
                editMode.toggle()
            } label: {
                Text("Edit")
                    .font(.myFont(style: .body, weight: .regular))
            }
            .buttonStyle(.automatic)
        }
    }
    
    @ViewBuilder
    private func addButton() -> some View {
        Button {
            goAdd = true
        } label: {
            Image(systemName: "plus")
        }
    }

    @ViewBuilder
    private func transactionDetails(_ transaction: Transaction) -> some View {
        NavigationLink {
            Group {
                Text("Adicionado em: \(transaction.date ?? .now, formatter: itemFormatter)")
                Text("Título: \(transaction.title ?? "Sem título")")
                Text("Tipo: \(transaction.type ?? "Sem tipo")")
                Text("Valor: \(transaction.value?.stringValue ?? "0")")
                Text("Categoria: \(transaction.category ?? "Sem categoria")")
            }
            .font(.myFont(size: 20))
        } label: {
            HStack {
                Text("Título: \(transaction.title ?? "Sem título")")
                    .font(.myFont(style: .body, weight: .regular))
                Spacer()
                Image(systemName: editMode ? "minus.circle.fill" : "applepencil.gen1")
                    .font(.myFont(style: .title3, weight: .regular))
                    .frame(width: 24, height: 24)
                    .contentShape(Rectangle())
                    .foregroundStyle(editMode ? .red : .primary)
                    .contentTransition(.symbolEffect(.replace))
                    .animation(.easeInOut(duration: 0.2), value: editMode)
                    .onTapGesture {
                        if editMode {
                            transactionsStore.delete(transaction)
                        } else {
                            goEdit = true
                        }
                    }
            }
        }
        .navigationLinkIndicatorVisibility(.hidden)
        .listRowBackground(Color.backdrop)
        .padding(.vertical, 5)
        
    }

    // MARK: - Funcs
    private func deleteItems(offsets: IndexSet) {
        withAnimation(.easeInOut(duration: 0.2)) {
            transactionsStore.delete(at: offsets)
        }
    }

}

// MARK: - Helpers
private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    return formatter
}()


// MARK: - Preview
private struct TransactionsView_PreviewContainer: View {
    var body: some View {
        TransactionsView()
            .environmentObject(
                TransactionsStore(
                    context: CoreDataManager.shared.container.viewContext
                )
            )
    }
}

#Preview("Light Mode") {
    TransactionsView_PreviewContainer()
        .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    TransactionsView_PreviewContainer()
        .preferredColorScheme(.dark)
}
