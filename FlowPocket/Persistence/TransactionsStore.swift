//
//  TransactionsStore.swift
//  FlowPocket
//

import Combine
import CoreData

@MainActor
final class TransactionsStore: ObservableObject {
    @Published private(set) var transactions: [Transaction] = []
    @Published private(set) var errorMessage: String?

    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
        load()
    }

    func load() {
        do {
            let request: NSFetchRequest<Transaction> = Transaction.fetchRequest()
            request.sortDescriptors = [
                NSSortDescriptor(keyPath: \Transaction.date, ascending: false)
            ]

            transactions = try context.fetch(request)
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func create(
        type: String,
        title: String,
        value: Decimal,
        category: String,
        date: Date = .now
    ) {
        perform {
            let transaction = Transaction(context: context)
            apply(
                type: type,
                title: title,
                value: value,
                category: category,
                date: date,
                to: transaction
            )
            try save()
        }
    }

    func update(
        _ transaction: Transaction,
        type: String,
        title: String,
        value: Decimal,
        category: String,
        date: Date
    ) {
        perform {
            apply(
                type: type,
                title: title,
                value: value,
                category: category,
                date: date,
                to: transaction
            )
            try save()
        }
    }

    func delete(_ transaction: Transaction) {
        perform {
            context.delete(transaction)
            try save()
        }
    }

    func delete(at offsets: IndexSet) {
        let selectedTransactions = offsets.compactMap { index in
            transactions.indices.contains(index) ? transactions[index] : nil
        }

        perform {
            selectedTransactions.forEach(context.delete)
            try save()
        }
    }

    func clearError() {
        errorMessage = nil
    }

    private func perform(_ operation: () throws -> Void) {
        do {
            try operation()
            load()
        } catch {
            errorMessage = error.localizedDescription
            print("Erro na transação: \(errorMessage ?? "⚠️")")
        }
    }

    private func apply(
        type: String,
        title: String,
        value: Decimal,
        category: String,
        date: Date,
        to transaction: Transaction
    ) {
        transaction.type = type
        transaction.title = title
        transaction.value = NSDecimalNumber(decimal: value)
        transaction.category = category
        transaction.date = date
    }

    private func save() throws {
        guard context.hasChanges else {
            return
        }

        try context.save()
    }
}
