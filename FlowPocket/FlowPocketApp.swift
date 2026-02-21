//
//  FlowPocketApp.swift
//  FlowPocket
//
//  Created by Luiz Gustavo Barros Campos on 19/02/26.
//

import SwiftUI
import CoreData

@main
struct FlowPocketApp: App {
    let coreDataManager = CoreDataManager.shared

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, coreDataManager.container.viewContext)
        }
    }
}
