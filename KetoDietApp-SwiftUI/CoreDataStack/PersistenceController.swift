//
//  PersistenceController.swift
//  KetoDietApp-SwiftUI
//
//  Created by user271428 on 5/4/25.
//
//
//
import CoreData

final class PersistenceController {

    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "RecipeModel")

        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }

        let description = container.persistentStoreDescriptions.first!
        
        // Print store URL
        if let storeURL = description.url {
            print("Core Data store location: \(storeURL.path)")
        }

        description.shouldMigrateStoreAutomatically = true
        description.shouldInferMappingModelAutomatically = true

        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                if let storeURL = storeDescription.url {
                    print("Migration error at: \(storeURL.path)")
                    print("Error: \(error.localizedDescription)")

                    // Delete corrupted store in dev mode
                    do {
                        try FileManager.default.removeItem(at: storeURL)
                        print("Deleted incompatible store.")
                    } catch {
                        fatalError("Could not delete store: \(error)")
                    }

                    // Retry loading after deletion
                    self.container.loadPersistentStores { _, retryError in
                        if let retryError = retryError {
                            fatalError("Failed to reload store after deletion: \(retryError)")
                        } else {
                            print("Store reloaded after deletion.")
                        }
                    }
                } else {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            } else {
                print("SQLite DB Path: \(storeDescription.url?.path ?? "Unknown path")")
                print("Core Data loaded successfully.")
            }
        }

        // Print model schema
        logModelSchema(model: container.managedObjectModel)
    }

    // Function to access the viewContext
    func getViewContext() -> NSManagedObjectContext {
        return container.viewContext
    }

    // Function to save context
    func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("Successfully saved to Core Data")
            } catch {
                print("Failed to save context: \(error)")
            }
        }
    }

    // Logs the schema of the managed object model
    func logModelSchema(model: NSManagedObjectModel) {
        print("Core Data Model Schema:")
        for entity in model.entities {
            print("Entity: \(entity.name ?? "Unknown")")
            for (name, attr) in entity.attributesByName {
                print("   - \(name): \(attr.attributeType)")
            }
        }
    }
}

