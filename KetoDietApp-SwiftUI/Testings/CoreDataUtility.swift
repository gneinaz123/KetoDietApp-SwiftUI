//
//  CoreDataUtility.swift
//  KetoDietApp-SwiftUI
//
//  Created by user271428 on 5/5/25.
//

import SwiftUI

struct CoreDataUtility: View {
    
    // Call the functions inside onAppear to ensure they're executed at the right time
    var body: some View {
        Text("Core Data Utility")
            .onAppear {
                // Fetch entity names and print context details when the view appears
                fetchEntityNames()
                printManagedObjectContextDetails()
            }
    }

    // Function to fetch and print all entity names in the Core Data model
    func fetchEntityNames() {
        let model = PersistenceController.shared.container.managedObjectModel
        
        // Get all entities from the model
        let entities = model.entities
        
        // Print all entity names
        print("Entity Names in the Core Data Model:")
        for entity in entities {
            print("Entity name: \(entity.name ?? "Unknown")")
        }
    }

    // Function to check and debug the managed object context
    func printManagedObjectContextDetails() {
        let persistentStoreCoordinator = PersistenceController.shared.container.persistentStoreCoordinator
        print("Persistent Store Coordinator is available: \(persistentStoreCoordinator)")
        
        let entities = PersistenceController.shared.container.managedObjectModel.entities
        print("Entities in model:")
        for entityDescription in entities {
            print("Entity name: \(entityDescription.name ?? "nil")")
        }
    }
}

struct CoreDataUtility_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataUtility()
            .previewDevice("iPhone 12") // Use a specific device
    }
}

