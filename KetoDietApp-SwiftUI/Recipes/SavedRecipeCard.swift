//
//  SavedRecipeCard.swift
//  KetoDietApp-SwiftUI
//
//  Created by user271428 on 5/6/25.
//

import SwiftUI

struct SavedRecipeCard: View {
    let recipe: RecentRecipe
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Image display
            if let urlString = recipe.image, let url = URL(string: urlString) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    case .failure(_):
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.gray)
                    case .empty:
                        ProgressView()
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(height: 180)
                .clipped()
                .cornerRadius(10)
            }
            
            // Title
            Text(recipe.title ?? "No title")
                .font(.headline)
                .lineLimit(1)
            
            // Nutritional Info
            VStack(alignment: .leading, spacing: 4) {
                Text("Calories: \(recipe.calories)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text("Protein: \(Int(recipe.protein))g")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text("Fat: \(Int(recipe.fat))g")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text("Carbs: \(Int(recipe.carbs))g")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
            }
            .padding(.top, 4)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .shadow(radius: 3)
    }
}




