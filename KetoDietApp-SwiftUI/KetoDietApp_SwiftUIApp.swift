//
//  KetoDietApp_SwiftUIApp.swift
//  KetoDietApp-SwiftUI
//
//  Created by user271428 on 5/2/25.
//

import SwiftUI

@main
struct KetoDietApp_SwiftUIApp: App {
    let persistenceController = PersistenceController.shared

        var body: some Scene {
            WindowGroup {
                        ContentView()
                            .environment(\.managedObjectContext, persistenceController.container.viewContext)
                            .onAppear {
                                print("Passed context to ContentView: \(persistenceController.container.viewContext)")
                                print("Using store: \(PersistenceController.shared.container.persistentStoreDescriptions.first?.url?.path ?? "Unknown")")

                            }
                    }
        }
}
