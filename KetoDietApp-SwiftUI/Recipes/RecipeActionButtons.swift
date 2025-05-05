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
            Button(action: {
                isSaved.toggle()
                if isSaved {
                    saveToRecent(recipe)
                }
            }) {
                Text("Save Recipe")
                    .fontWeight(.semibold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(isSaved ? Color.blue : Color.clear)
                    .foregroundColor(isSaved ? .white : .blue)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: 2)
                    )
                    .cornerRadius(10)
            }

            Button(action: {
                isDone.toggle()
                if isDone {
                    saveToConsume(recipe)
                }
            }) {
                Text("Done")
                    .fontWeight(.semibold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(isDone ? Color.blue : Color.clear)
                    .foregroundColor(isDone ? .white : .blue)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: 2)
                    )
                    .cornerRadius(10)
            }
        }
        .padding([.horizontal, .bottom])
    }

    private func saveToRecent(_ recipe: RecipeDetails) {
        let newRecentRecipe = RecentRecipe(context: viewContext)
        newRecentRecipe.title = recipe.recipe
        newRecentRecipe.category = recipe.category.category
        newRecentRecipe.calories = Int64(recipe.calories ?? 0)
        newRecentRecipe.protein = Double(recipe.protein_in_grams ?? 0)
        newRecentRecipe.fat = Double(recipe.fat_in_grams ?? 0)
        //newRecentRecipe. = Double(recipe.carbohydrates_in_grams ?? 0)
        
        do {
            try viewContext.save()
            print("Saved to Recent Recipe")
        } catch{
            print("Failed to save recent recipe: \(error)")
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
}



