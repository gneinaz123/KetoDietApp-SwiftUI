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
        VStack(alignment: .leading, spacing: 4){
//            AsyncImage(url: URL(string: recipe.image)){ image in
//                image.resizable()
//            } placeholder: {
//                Color.gray
//            }
//            .frame(height: 200)
//            .cornerRadius(8)
            
            Text(recipe.recipe)
                .font(.headline)
            
            if let calories = recipe.calories{
                Text("Calories: \(calories)")
            }
            if let protein = recipe.protein_in_grams{
                Text("Protein: \(Int(protein))g")
            }
            if let fat = recipe.fat_in_grams{
                Text("Fat: \(Int(fat))g")
            }
            if let carbs = recipe.carbohydrates_in_grams{
                Text("Carbs: \(Int(carbs))g")
            }
        }
        .padding(.vertical, 6)
    }
}


