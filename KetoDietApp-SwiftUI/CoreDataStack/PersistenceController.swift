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
class PersistenceController {
    static let shared = PersistenceController() // Singleton instance

    // Persistent container for Core Data
    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "RecipeModel") // Replace with your model name
        print("Persistent container initialized: \(container)")
        print("View context: \(container.viewContext)")

        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }

    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }
    
}

