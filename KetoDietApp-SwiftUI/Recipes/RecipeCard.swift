//
//  RecipeCard.swift
//  KetoDietApp-SwiftUI
//
//  Created by user271428 on 5/2/25.
//

import SwiftUI

struct RecipeCard: View {
    let recipe: RecipeDetails

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            //Recipe Image
            if let imageUrl = recipe.image, let url = URL(string: imageUrl) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                }
                .frame(height: 160)
                .clipped()
                .cornerRadius(12)
            }

            Text(recipe.recipe)
                .font(.headline)
                .foregroundColor(.primary)
                .lineLimit(2)
                .minimumScaleFactor(0.9)

            if let calories = recipe.calories {
                Text("Calories: \(calories)")
                    .font(.subheadline)
            }
            if let protein = recipe.protein_in_grams {
                Text("Protein: \(Int(protein))g")
                    .font(.subheadline)
            }
            if let fat = recipe.fat_in_grams {
                Text("Fat: \(Int(fat))g")
                    .font(.subheadline)
            }
            if let carbs = recipe.carbohydrates_in_grams {
                Text("Carbs: \(Int(carbs))g")
                    .font(.subheadline)
            }

            Text("Category: \(recipe.category.category)")
                .font(.footnote)
                .foregroundColor(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
        )
        .padding(.horizontal)
    }
}



