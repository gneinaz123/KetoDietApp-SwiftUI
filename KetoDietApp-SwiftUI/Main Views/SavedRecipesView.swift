//
//  SavedRecipesView.swift
//  KetoDietApp-SwiftUI
//
//  Created by user271428 on 5/6/25.
//

import SwiftUI

struct SavedRecipesView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        entity: RecentRecipe.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \RecentRecipe.title, ascending: true)]
    ) var RecentRecipes: FetchedResults<RecentRecipe>
    var body: some View {
        NavigationView{
            ScrollView{
                LazyVStack(spacing: 16){
                    ForEach(RecentRecipes){ recipe in
                        SavedRecipeCard(recipe: recipe)
                    }
                }
                .padding()
            }
            .navigationTitle("Saved Recipes")
        }
    }
}

#Preview {
    SavedRecipesView()
}
