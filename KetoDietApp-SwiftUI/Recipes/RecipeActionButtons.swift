//
//  RecipeActionButtons.swift
//  KetoDietApp-SwiftUI
//
//  Created by user271428 on 5/5/25.
//

import SwiftUI
import CoreData

struct RecipeActionButtons: View {
    @Binding var isSaved: Bool
    @Binding var isDone: Bool
    let recipe: RecipeDetails
    let viewContext: NSManagedObjectContext

    var body: some View {
        HStack(spacing: 20) {
            // Save Toggle Button
            Button(action: {
                isSaved.toggle()
                if isSaved {
                    saveToRecent(recipe)
                }
            }) {
                HStack {
                    Text("Save")
                    if isSaved {
                        Image(systemName: "checkmark")
                    }
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(isSaved ? Color.blue.opacity(0.2) : Color.gray.opacity(0.1))
                .foregroundColor(isSaved ? .blue : .primary)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(isSaved ? Color.blue : Color.gray, lineWidth: 1)
                )
                .clipShape(Capsule())
            }

            // Done Toggle Button
            Button(action: {
                isDone.toggle()
                if isDone {
                    saveToConsume(recipe)
                }
            }) {
                HStack {
                    Text("Done")
                    if isDone {
                        Image(systemName: "checkmark")
                    }
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(isDone ? Color.green.opacity(0.2) : Color.gray.opacity(0.1))
                .foregroundColor(isDone ? .green : .primary)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(isDone ? Color.green : Color.gray, lineWidth: 1)
                )
                .clipShape(Capsule())
            }
        }

        .padding([.horizontal, .bottom])
        .frame(maxWidth: .infinity)
    }


//        newRecentRecipe.id = UUID()
//        newRecentRecipe.title = "Test Recipe"
//        newRecentRecipe.category = "Test Category"
//        newRecentRecipe.calories = 100
//        newRecentRecipe.protein = 10
//        newRecentRecipe.fat = 10
//        newRecentRecipe.carbs = 5
//        NSLog("excuting")


    private func saveToRecent(_ recipe: RecipeDetails) {
        print("Starting saveToRecent...")

        guard let persistentStoreCoordinator = viewContext.persistentStoreCoordinator else {
            print("Persistent Store Coordinator is not available")
            return
        }
        print("Persistent Store Coordinator is available: \(persistentStoreCoordinator)")


        if let entityDescriptions = viewContext.persistentStoreCoordinator?.managedObjectModel.entities {
                print("Entities in model:")
                for entityDescription in entityDescriptions {
                    print("Entity name: \(entityDescription.name ?? "nil")")
                }
            } else {
                print("Unable to access the persistent store coordinator or managed object model.")
            }
//        assert(viewContext != nil, "viewContext is nil! Make sure it's injected properly.")
//        
//        guard let modelName = viewContext.persistentStoreCoordinator?.managedObjectModel,
//              let entities = modelName.entitiesByName["RecentRecipe"] else {
//            print("Unable to access model or entity description for RecentRecipe")
//            return
//        }
        DispatchQueue.main.async {
            let newRecentRecipe = RecentRecipe(context: viewContext)
//            let newRecentRecipe = RecentRecipe(context: PersistenceController.shared.container.viewContext)
            let generatedUUID = UUID()
            newRecentRecipe.id = generatedUUID
            newRecentRecipe.title = recipe.recipe
            newRecentRecipe.category = recipe.category.category
            newRecentRecipe.calories = Int64(recipe.calories ?? 0)
            newRecentRecipe.protein = Double(recipe.protein_in_grams ?? 0)
            newRecentRecipe.fat = Double(recipe.fat_in_grams ?? 0)
            newRecentRecipe.carbs = Double(recipe.carbohydrates_in_grams ?? 0)
            
            print("About to save new recipe to context:")
            print("ID: \(generatedUUID)")
            print("Title: \(newRecentRecipe.title ?? "nil")")
            print("Category: \(newRecentRecipe.category ?? "nil")")
            print("Calories: \(newRecentRecipe.calories)")
            print("Protein: \(newRecentRecipe.protein)")
            print("Fat: \(newRecentRecipe.fat)")
            print("Carbs: \(newRecentRecipe.carbs)")

            print("viewContext before save: \(viewContext)")
            do {
//                PersistenceController.shared.saveContext()
                try viewContext.save()
                viewContext.refreshAllObjects()
//                viewContext.processPendingChanges()
                print(" Successfully saved to Core Data")
                let fetchRequest: NSFetchRequest<RecentRecipe> = RecentRecipe.fetchRequest()
                let recipes = try viewContext.fetch(fetchRequest)
                print("Fetched recipes count: \(recipes.count)")
            } catch let error as NSError {
                // error information
                print("Core Data Save Error")
                print("Domain: \(error.domain)")
                print("Code: \(error.code)")
                print("Description: \(error.localizedDescription)")
                print("User Info: \(error.userInfo)")
                
                // print the persistent store details
                if let store = viewContext.persistentStoreCoordinator?.persistentStores.first {
                    print("Persistent Store: \(store)")
                }
            }
        }
    }
    // Remove the recipe from Core Data
    private func removeFromRecent(_ recipe: RecipeDetails) {
        let fetchRequest: NSFetchRequest<RecentRecipe> = RecentRecipe.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", recipe.recipe)

        do {
            let results = try viewContext.fetch(fetchRequest)
            if let existingRecipe = results.first {
                viewContext.delete(existingRecipe)
                try viewContext.save()
                print("Successfully removed from Recent Recipe")
            }
        } catch {
            print("Failed to remove from Recent Recipe: \(error)")
        }
    }


    private func saveToConsume(_ recipe: RecipeDetails){
        let consumed = ConsumedRecipe(context: viewContext)
        consumed.id = Int64(recipe.id)
        consumed.title = recipe.recipe
        consumed.carbs = recipe.carbohydrates_in_grams ?? 0
        consumed.calories = Int64(recipe.calories ?? 0)
        consumed.protein = recipe.protein_in_grams ?? 0
        consumed.fat = recipe.fat_in_grams ?? 0
        consumed.carbs = recipe.carbohydrates_in_grams ?? 0
        
        do {
            try viewContext.save()
            print("Saved to consumed Recipe")
        }catch{
            print("Failed to save consued recipe: \(error)")
        }
    }
    // Remove the recipe in Core Data
    private func removeFromConsume(_ recipe: RecipeDetails) {
        let fetchRequest: NSFetchRequest<ConsumedRecipe> = ConsumedRecipe.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", recipe.recipe)

        do {
            let results = try viewContext.fetch(fetchRequest)
            if let existingRecipe = results.first {
                viewContext.delete(existingRecipe)
                try viewContext.save()
                print("Successfully removed from Consumed Recipe")
            }
        } catch {
            print("Failed to remove from Consumed Recipe: \(error)")
        }
    }
}



