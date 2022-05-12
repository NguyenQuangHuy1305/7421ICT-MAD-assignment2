//
//  Assignment2App.swift
//  Assignment2
//
//  Created by Nguyen Quang Huy on 3/5/2022.
//

import SwiftUI
import MapKit

@main
struct Assignment2App: App {    
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
