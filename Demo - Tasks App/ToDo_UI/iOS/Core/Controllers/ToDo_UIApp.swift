//
//  ToDo_UIApp.swift
//  ToDo_UI
//
//  Created by Shubham on 11/11/24.
//

import SwiftUI

@main
struct ToDo_UIApp: App {
    
    // MARK: - Variables
    let persistenceController = PersistenceController.shared

    
    // MARK: - Views
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .preferredColorScheme(.light)
        }
    }
}
