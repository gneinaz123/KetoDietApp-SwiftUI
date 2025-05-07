//
//  RecipeRow.swift
//  KetoDietApp-SwiftUI
//
//  Created by user271428 on 5/4/25.
//

import SwiftUI

struct RecipeRow: View {
    let recipe: RecipeDetails
    
    var body: some View {
        NavigationLink(destination: ViewRecipe(recipe: recipe)) {
            HStack(alignment: .top, spacing: 16) {
                RecipeCard(recipe: recipe)
                    .frame(maxWidth: .infinity) 
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                    .padding(.trailing)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).fill(Color(UIColor.secondarySystemBackground)))
        }
        .buttonStyle(PlainButtonStyle())
    }
}
