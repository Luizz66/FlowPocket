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
    let coreDataManager = CoreDataManager.shared

    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(\.managedObjectContext, coreDataManager.container.viewContext)
        }
    }
}
