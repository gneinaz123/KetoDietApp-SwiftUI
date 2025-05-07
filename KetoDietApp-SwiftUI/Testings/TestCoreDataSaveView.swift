//import SwiftUI
//import CoreData
//
//struct TestCoreDataSaveView: View {
//    let recipe: RecipeDetails
//    @Environment(\.managedObjectContext) private var viewContext
//
//    var body: some View {
//        VStack {
//            Button("Save Dummy Recipe") {
//                saveDummyRecipe()
//            }
//            .padding()
//        }
//    }
//    
//    private func saveDummyRecipe() {
//        let newRecentRecipe = RecentRecipe(context: viewContext)
//        let generatedUUID = UUID()
//        newRecentRecipe.id = generatedUUID
//        newRecentRecipe.title = recipe.recipe
//        newRecentRecipe.category = recipe.category
//        newRecentRecipe.calories = Int64(recipe.calories ?? 0)
//        newRecentRecipe.protein = Double(recipe.protein_in_grams ?? 0)
//        newRecentRecipe.fat = Double(recipe.fat_in_grams ?? 0)
//        newRecentRecipe.carbs = Double(recipe.carbohydrates_in_grams ?? 0)
//
//        do {
//            try viewContext.save()
//            print("Dummy recipe saved successfully!")
//        } catch {
//            print("Failed to save dummy recipe: \(error.localizedDescription)")
//        }
//    }
//}
//
//struct TestCoreDataSaveView_Previews: PreviewProvider {
//    static var previews: some View {
//        // Create an in-memory Core Data container for preview
//        let container = PersistenceController(inMemory: true)
//        let context = container.container.viewContext
//        
//        // Create a dummy object for the preview context
//        let newRecipe = RecipeDetails(context: context)  // Use 'context' here
//        newRecipe.id = Int64(Date().timeIntervalSince1970)
//        newRecipe.recipe = "Preview Recipe"
//        newRecipe.category = "Preview Category"
//        newRecipe.calories = 100
//        newRecipe.protein_in_grams = 5
//        newRecipe.fat_in_grams = 3
//        newRecipe.carbohydrates_in_grams = 20
//        
//        return TestCoreDataSaveView(recipe: newRecipe) // Pass newRecipe as the recipe
//            .environment(\.managedObjectContext, context) // Inject context
//    }
//}
