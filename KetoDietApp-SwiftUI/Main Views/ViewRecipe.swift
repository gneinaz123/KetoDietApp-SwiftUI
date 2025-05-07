//
//  ViewRecipe.swift
//  KetoDietApp-SwiftUI
//
//  Created by user271428 on 5/3/25.
//
import SwiftUI
import CoreData

struct ViewRecipe: View {
    let recipe: RecipeDetails
    @State private var isSaved: Bool = false
    @State private var isDone: Bool = false
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                if let imageURLString = recipe.image,
                   let url = URL(string: imageURLString) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: geometry.size.width,
                                       height: geometry.size.height)
                                .clipped()
                                .opacity(1)
                                .ignoresSafeArea()
                        case .failure(_), .empty:
                            Color.gray.opacity(0.3).ignoresSafeArea()
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
                
                ScrollView {

                    RecipeDetailView(recipe: recipe)
                        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)


//                    RecipeActionButtons(isSaved: $isSaved,
//                                        isDone: $isDone, recipe: recipe,
//                                        viewContext: PersistenceController.shared.container.viewContext
////                                        viewContext: viewContext
//                    )

                    
                }
            }
            
        }
        .navigationTitle("Recipe Details")
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
}
