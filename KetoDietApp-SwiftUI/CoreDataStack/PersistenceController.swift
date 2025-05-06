//
//  PersistenceController.swift
//  KetoDietApp-SwiftUI
//
//  Created by user271428 on 5/4/25.
//

import CoreData

//struct PersistenceController{
//    static let shared = PersistenceController()
//    
//    let container : NSPersistentContainer
//    
////    init(){
////        container = NSPersistentContainer(name: "RecipeModel")
////        container.loadPersistentStores{_, error in
////            if let error = error as NSError? {
////                fatalError("Unresolved Error \(error), \(error.userInfo)")
////            }
////        }
//    init(inMemory: Bool = false) {
//            container = NSPersistentContainer(name: "RecipeModel") // Must match your `.xcdatamodeld` file name
//            if inMemory {
//                container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
//            }
//            container.loadPersistentStores { description, error in
//                if let error = error {
//                    fatalError("Core Data store failed: \(error.localizedDescription)")
//                }
//            }
//        }
//    
//}
// Core Data Stack Setup
//class PersistenceController {
//    static let shared = PersistenceController() // Singleton instance
//
//    // Persistent container for Core Data
//    let container: NSPersistentContainer
//
//    init() {
//        container = NSPersistentContainer(name: "RecipeModel") 
//        print("Persistent container initialized: \(container)")
//        print("View context: \(container.viewContext)")
//
//        let storeURL = container.persistentStoreDescriptions.first?.url
//        let description = NSPersistentStoreDescription(url: storeURL!)
//
//        description.shouldMigrateStoreAutomatically = true
//        description.shouldInferMappingModelAutomatically = true
//        container.persistentStoreDescriptions = [description]
//
//        container.loadPersistentStores { storeDescription, error in
//            if let error = error as NSError? {
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        }
//
//    }
//
//    var viewContext: NSManagedObjectContext {
//        return container.viewContext
//    }
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

        // DEBUG: Print store URL
        if let storeURL = description.url {
            print("🗂 Core Data store location: \(storeURL.path)")
        }

        // Clear store if migration fails
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
                print("✅ Core Data loaded successfully.")
            }
        }

        // DEBUG: Print model schema
        logModelSchema(model: container.managedObjectModel)
    }

    /// Prints all entities and their attributes in the current model
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






