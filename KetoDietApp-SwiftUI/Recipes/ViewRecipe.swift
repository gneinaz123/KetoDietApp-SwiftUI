//
//  ViewRecipe.swift
//  KetoDietApp-SwiftUI
//
//  Created by user271428 on 5/3/25.
//

import SwiftUI

struct ViewRecipe: View {
    let recipe: RecipeDetails

    var body: some View {
        ZStack(alignment: .top) {
//            if let imageURLString = recipe.image, let url = URL(string: imageURLString){
//                AsyncImage(url: url) { phase in
//                    switch phase{
//                    case .success(let image):
//                        image
//                            .resizable()
//                            .scaledToFill()
//                            .blur(radius: 10)
//                            .opacity(0.3)
//                            .ignoresSafeArea()
//                    case .failure(_):
//                        Color.gray.opacity(0.3).ignoresSafeArea()
//                    case .empty:
//                        Color.gray.opacity(0.1).ignoresSafeArea()
//                    @unknown default:
//                        EmptyView()
//                    }
//                    
//                    
//                }
//            }
            ScrollView{
                VStack(alignment: .leading, spacing: 16) {
                    
                        Text("Meal category: \(recipe.category.category)")
                            .font(.headline)
                        
                        VStack(alignment: .leading, spacing: 4){
                            
                            // Example image placeholder — you can uncomment if your API has image URLs
                            // AsyncImage(url: URL(string: recipe.image)) { image in
                            //     image.resizable()
                            // } placeholder: {
                            //     Color.gray
                            // }
                            // .frame(height: 200)
                            // .cornerRadius(10)
                            Text("Nutritional Information")
                                .font(.title3).bold()
                            
                            if let calories = recipe.calories {
                                Text("Calories: \(calories)")
                                    .font(.headline)
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
                        
                        
                        VStack(alignment: .leading, spacing: 4){
                            Text("Ingredients")
                                .font(.title3).bold()
                            ForEach(0..<recipe.ingredients.count, id: \.self){ index in
                                let amount = recipe.measurements[index] ?? 0
                                let ingredient = recipe.ingredients[index]
                                Text(". \(amount) \(ingredient)")
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 4){
                            Text("Preparation Steps")
                                .font(.title3).bold()
                            ForEach(recipe.directions.indices, id: \.self){ index in
                                
                                Text("\(index + 1). \(recipe.directions[index])")
                                    .font(.body)
                            }
                        }
                    
                }
                .padding()
            }
        }
        .navigationTitle("Recipe Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

