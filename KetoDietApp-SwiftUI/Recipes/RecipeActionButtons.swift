//
//  RecipeActionButtons.swift
//  KetoDietApp-SwiftUI
//
//  Created by user271428 on 5/5/25.
//

import SwiftUI
import CoreData

struct RecipeActionButtons: View {
    @Binding var isSaved: Bool
    @Binding var isDone: Bool
    let recipe: RecipeDetails
    let viewContext: NSManagedObjectContext

    var body: some View {
        HStack(spacing: 20) {
            Button(action: {
                isSaved.toggle()
                if isSaved {
                    saveToRecent(recipe)
                }
            }) {
                Text("Save Recipe")
                    .fontWeight(.semibold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(isSaved ? Color.blue : Color.clear)
                    .foregroundColor(isSaved ? .white : .blue)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: 2)
                    )
                    .cornerRadius(10)
            }

            Button(action: {
                isDone.toggle()
                if isDone {
                    saveToConsumed(recipe)
                }
            }) {
                Text("Done")
                    .fontWeight(.semibold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(isDone ? Color.blue : Color.clear)
                    .foregroundColor(isDone ? .white : .blue)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: 2)
                    )
                    .cornerRadius(10)
            }
        }
        .padding([.horizontal, .bottom])
    }

    // Dummy CoreData saving functions — update these as needed
    private func saveToRecent(_ recipe: RecipeDetails) {
        // Add CoreData saving logic here
        print("Recipe saved to recent.")
    }

    private func saveToConsumed(_ recipe: RecipeDetails) {
        // Add CoreData saving logic here
        print("Recipe saved as consumed.")
    }
}



