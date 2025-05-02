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
        VStack(alignment: .leading, spacing: 10){
            AsyncImage(url: URL(string: recipe.image)){ image in
                image.resizable()
            } placeholder: {
                Color.gray
            }
            .frame(height: 200)
            .cornerRadius(8)
            
            Text(recipe.recipe)
                .font(.headline)
            
            Text("Calories: \(recipe.calories)")
            if let protein = recipe.protein_in_grams{
                Text("Protein: \(protein)g")
            }
            if let fat = recipe.fat_in_grams{
                Text("Fat: \(fat)g")
            }
            if let carbs = recipe.carbohydrates_in_grams{
                Text("Carbs: \(carbs)g")
            }
        }
        .padding(.bottom)
    }
}


