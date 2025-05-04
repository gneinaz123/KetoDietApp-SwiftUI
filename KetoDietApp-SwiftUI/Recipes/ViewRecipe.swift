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
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(recipe.recipe)
                    .font(.largeTitle)
                    .fontWeight(.bold)

                // Example image placeholder — you can uncomment if your API has image URLs
                // AsyncImage(url: URL(string: recipe.image)) { image in
                //     image.resizable()
                // } placeholder: {
                //     Color.gray
                // }
                // .frame(height: 200)
                // .cornerRadius(10)

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

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Recipe Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
