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
    
    // Remove duplicates by title
        var uniqueRecipes: [RecentRecipe] {
            Dictionary(grouping: RecentRecipes, by: { $0.title ?? "" })
                .compactMap { $0.value.first }
        }
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 16) {
                    
                    Text("Saved Recipes")
                        .font(.title)
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                        .fontWeight(.bold)
                    ForEach(uniqueRecipes) { recipe in
                        SavedRecipeCard(recipe: recipe)
                    }
//                    ForEach(uniqueRecipes) { recipe in
//                                            NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
//                                                SavedRecipeCard(recipe: recipe)
//                                            }
//                                        }
                }
                .padding()
            }
        }
        .navigationTitle("Saved Recipes")
    }
    
}
#Preview {
    SavedRecipesView()
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
}

