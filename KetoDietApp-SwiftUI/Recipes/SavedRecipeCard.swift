//
//  SavedRecipeCard.swift
//  KetoDietApp-SwiftUI
//
//  Created by user271428 on 5/6/25.
//

import SwiftUI

struct SavedRecipeCard: View {
    let recipe : RecentRecipe
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            if let urlString = recipe.image, let url = URL(string: urlString){
                AsyncImage(url: url){ phase in
                    switch phase{
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
            Text(recipe.title ?? "No title")
                .font(.headline)
            
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .shadow(radius: 3)
    }
}


