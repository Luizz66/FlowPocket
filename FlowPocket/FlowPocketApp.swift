//
//  FlowPocketApp.swift
//  FlowPocket
//
//  Created by Luiz Gustavo Barros Campos on 19/02/26.
//

import SwiftUI
import CoreData
import FirebaseCore

@main
struct FlowPocketApp: App {
    @StateObject private var transactionsStore: TransactionsStore

    init() {
        FirebaseApp.configure()
        let coreDataManager = CoreDataManager.shared
        _transactionsStore = StateObject(
            wrappedValue: TransactionsStore(
                context: coreDataManager.container.viewContext
            )
        )
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(transactionsStore)
        }
    }
}
