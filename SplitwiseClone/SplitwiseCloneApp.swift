//
//  SplitwiseCloneApp.swift
//  SplitwiseClone
//
//  Created by apple on 17.01.26.
//

import SwiftUI

@main
struct SplitwiseCloneApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            DashboardFriendsView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
