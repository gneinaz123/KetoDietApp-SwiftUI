//
//  PersistenceController.swift
//  KetoDietApp-SwiftUI
//
//  Created by user271428 on 5/4/25.
//

import CoreData

struct PersistenceController{
    static let shared = PersistenceController()
    
    let container : NSPersistentContainer
    
    init(){
        container = NSPersistentContainer(name: "RecipeModel")
        container.loadPersistentStores{_, error in
            if let error = error as NSError? {
                fatalError("Unresolved Error \(error), \(error.userInfo)")
            }
        }
    }
}
