//
//  ViewRecipe.swift
//  KetoDietApp-SwiftUI
//
//  Created by user271428 on 5/3/25.
//
import SwiftUI
import CoreData

struct ViewRecipe: View {
    let recipe: RecipeDetails
    @State private var isSaved: Bool = false
    @State private var isDone: Bool = false
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                if let imageURLString = recipe.image,
                   let url = URL(string: imageURLString) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: geometry.size.width,
                                       height: geometry.size.height)
                                .clipped()
                                .opacity(1)
                                .ignoresSafeArea()
                        case .failure(_), .empty:
                            Color.gray.opacity(0.3).ignoresSafeArea()
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        // Meal Category
                        Text("Meal category: \(recipe.category.category)")
                            .font(.headline)
                        
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
                        
                        // Ingredients
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Ingredients")
                                .font(.title3).bold()
                            
                            ForEach(0..<recipe.ingredients.count, id: \.self) { index in
                                let amount = recipe.measurements[index] ?? 0
                                let ingredient = recipe.ingredients[index]
                                Text("• \(amount) \(ingredient)")
                            }
                        }
                        
                        // Preparation
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Preparation Steps")
                                .font(.title3).bold()
                            
                            ForEach(recipe.directions.indices, id: \.self) { index in
                                Text("\(index + 1). \(recipe.directions[index])")
                                    .font(.body)
                            }
                        }
                        
                        
                        
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.white.opacity(0.85))
                    .cornerRadius(12)
                    .padding()
                    
                    RecipeActionButtons(isSaved: $isSaved, isDone: $isDone, recipe: recipe, viewContext: PersistenceController.shared.container.viewContext)

                    
                }
            }
        }
        .navigationTitle("Recipe Details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
}
