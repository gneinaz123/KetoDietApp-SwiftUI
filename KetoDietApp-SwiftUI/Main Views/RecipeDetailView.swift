//
//  RecipeDetailView.swift
//  KetoDietApp-SwiftUI
//
//  Created by user271428 on 5/6/25.
//
import SwiftUI
import CoreData

struct RecipeDetailView: View {
    let recipe: RecipeDetails
    @State private var showIngredients = false
    @State private var showPreparation = false
    @State private var isSaved = false
    @State private var isDone = false
//    @State private var viewContext = PersistenceController.shared.container.viewContext
    @Environment(\.managedObjectContext) private var viewContext
    

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Meal Category
                Text("Meal category: \(recipe.category.category)")
                    .font(.headline)
                    .foregroundColor(.primary)
                    .padding(.top)

                // Nutritional Info
                VStack(alignment: .leading, spacing: 4) {
                    Text("Nutritional Information")
                        .font(.title3).bold()

                    if let calories = recipe.calories {
                        Text("Calories: \(calories)")
                    }
                    if let protein = recipe.protein_in_grams {
                        Text("Protein: \(Int(protein))g")
                    }
                    if let fat = recipe.fat_in_grams {
                        Text("Fat: \(Int(fat))g")
                    }
                    if let carbs = recipe.carbohydrates_in_grams {
                        Text("Carbs: \(Int(carbs))g")
                    }
                }
                .padding(.bottom)

                // Ingredients Section
                VStack(alignment: .leading, spacing: 4) {
                    Text("Ingredients")
                        .font(.title3).bold()

                    Button(action: {
                        withAnimation {
                            showIngredients.toggle()
                        }
                    }) {
                        HStack {
                            Text("Show Ingredients")
                                .font(.body)
                                .foregroundColor(.accentColor)
                            Spacer()
                            Image(systemName: showIngredients ? "chevron.down" : "chevron.right")
                                .foregroundColor(.accentColor)
                        }
                    }

                    if showIngredients {
                        ForEach(0..<recipe.ingredients.count, id: \.self) { index in
                            let amount = recipe.measurements[index] ?? 0
                            let ingredient = recipe.ingredients[index]
                            Text("• \(amount) \(ingredient)")
                                .font(.body)
                        }
                    }
                }
                .padding(.bottom)

                // Preparation Section
                VStack(alignment: .leading, spacing: 4) {
                    Text("Preparation Steps")
                        .font(.title3).bold()

                    Button(action: {
                        withAnimation {
                            showPreparation.toggle()
                        }
                    }) {
                        HStack {
                            Text("Show Preparation")
                                .font(.body)
                                .foregroundColor(.accentColor)
                            Spacer()
                            Image(systemName: showPreparation ? "chevron.down" : "chevron.right")
                                .foregroundColor(.accentColor)
                        }
                    }

                    if showPreparation {
                        ForEach(recipe.directions.indices, id: \.self) { index in
                            Text("\(index + 1). \(recipe.directions[index])")
                                .font(.body)
                        }
                    }
                }
                .padding(.bottom)
                RecipeActionButtons(isSaved: $isSaved, isDone: $isDone, recipe: recipe, viewContext: viewContext)
                                    .padding([.horizontal, .bottom])
                
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white.opacity(0.85))
            .cornerRadius(12)
            .padding(.horizontal)
        }
        .navigationTitle(recipe.recipe)
        .onAppear {
                    isSaved = isRecipeAlreadySaved(recipe)
                    isDone = isRecipeAlreadyConsumed(recipe)
                }
    }
    private func isRecipeAlreadySaved(_ recipe: RecipeDetails) -> Bool {
           let fetch: NSFetchRequest<RecentRecipe> = RecentRecipe.fetchRequest()
           fetch.predicate = NSPredicate(format: "title == %@", recipe.recipe)
           return (try? viewContext.fetch(fetch).isEmpty == false) ?? false
       }

       private func isRecipeAlreadyConsumed(_ recipe: RecipeDetails) -> Bool {
           let fetch: NSFetchRequest<ConsumedRecipe> = ConsumedRecipe.fetchRequest()
           fetch.predicate = NSPredicate(format: "title == %@", recipe.recipe)
           return (try? viewContext.fetch(fetch).isEmpty == false) ?? false
       }
}

