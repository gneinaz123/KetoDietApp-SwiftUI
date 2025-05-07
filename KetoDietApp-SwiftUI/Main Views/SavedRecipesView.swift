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
        
        // Daily Target Section
              NavigationStack {
            ScrollView {
                
               
                
                BlueBoxText(text: "Saved Recipes").padding(.bottom,30).padding(.top,10)
                
                LazyVStack(spacing: 16) {
                
                    //Text("Saved Recipes")
                              //              .font(.title)
                               //             .foreground//Color(.blue)
                             //               .frame(maxWidth: .infinity)
                              //              .multilineTextAlignment(.center)
                           //                 .fontWeight(.bold)
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
struct BlueBoxText: View {
    let text: String

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "checkmark")
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .regular))

            Text(text)
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.white)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
        .background(Color(red: 0.196, green: 0.290, blue: 0.659))
        .clipShape(RightCapsuleShape())
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct RightCapsuleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let radius = rect.height / 2

        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - radius, y: rect.minY))
        path.addArc(center: CGPoint(x: rect.maxX - radius, y: rect.midY),
                    radius: radius,
                    startAngle: Angle(degrees: -90),
                    endAngle: Angle(degrees: 90),
                    clockwise: false)
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()

        return path
    }
}



#Preview {
    SavedRecipesView()
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
}

