//
//  MockDataView.swift
//  KetoDietApp-SwiftUI
//
//  Created by user271428 on 5/7/25.
//

import SwiftUI
import CoreData

struct MockDataView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    // Use a method to populate mock data
    func populateMockData() {
        // Prevent adding duplicate mock data
        let fetchRequest: NSFetchRequest<RecentRecipe> = RecentRecipe.fetchRequest()
        if let count = try? viewContext.count(for: fetchRequest), count > 0 {
            return // Data already exists
        }
        
        // Add mock recipes
        let recipe1 = RecentRecipe(context: viewContext)
        recipe1.id = UUID()
        recipe1.title = "Test Recipe"
        recipe1.category = "Test Category"
        recipe1.calories = 100
        recipe1.protein = 10
        recipe1.fat = 10
        recipe1.carbs = 5
        
        let recipe2 = RecentRecipe(context: viewContext)
        recipe1.id = UUID()
        recipe1.title = "Test Recipe"
        recipe1.category = "Test Category"
        recipe1.calories = 100
        recipe1.protein = 10
        recipe1.fat = 10
        recipe1.carbs = 5
        
        let recipe3 = RecentRecipe(context: viewContext)
        recipe1.id = UUID()
        recipe1.title = "Test Recipe"
        recipe1.category = "Test Category"
        recipe1.calories = 100
        recipe1.protein = 10
        recipe1.fat = 10
        recipe1.carbs = 5
        
        // Save context
        do {
            try viewContext.save()
        } catch {
            print("Failed to insert mock data: \(error)")
        }
    }
    
    var body: some View {
        VStack {
            Button("Add Mock Data") {
                populateMockData()
            }
            
            SavedRecipesView()
        }
        .padding()
    }
}

#Preview {
    MockDataView()
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
}
