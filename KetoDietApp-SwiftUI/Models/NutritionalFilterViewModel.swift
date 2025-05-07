//
//  NutritionalFilterViewModel.swift
//  KetoDietApp-SwiftUI
//
//  Created by user271428 on 5/2/25.
//
import Foundation
import Combine
import SwiftUI

class NutritionalFilterViewModel: ObservableObject {
    @Published var selectedCategory: NutrientCategory = .protein
    @Published var selectedMealCategory: MealCategory = .all
    @Published var minAmount: String = ""
    @Published var maxAmount: String = ""
    @Published var filters : [Filter] = []
    @Published var recipes: [RecipeDetails] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    private let service: RecipeServiceProtocol
    
    init(service: RecipeServiceProtocol = APIService.shared){
        self.service = service
    }
    
    func addFilter() {
        let validation = NutritionalFilterValidator.validate(minText: minAmount, maxText: maxAmount)
        
        if let error = validation.error {
            self.errorMessage = error
            return
        }

        if let min = validation.min, let max = validation.max {
            let newFilter = Filter(category: selectedCategory, min: min, max: max)
            filters.append(newFilter)
            minAmount = ""
            maxAmount = ""
            errorMessage = nil
        }
    }

    
    func removeFilters(_ filter: Filter){
        filters.removeAll {$0.id == filter.id}
    }
    func searchRecipes(){
//        isLoading = true
//        APIService.shared.fetchRecipes(for: filters){ [weak self] recipes in
//            self?.recipes = recipes
//            self?.isLoading = false
//        }
        guard let primaryFilter = filters.first else { return }
//        let selectedMealsCategory = selectedMealCategory?.rawValue
        let selectedMealsCategory = selectedMealCategory == .all ? nil : selectedMealCategory.rawValue

        APIService.shared.fetchRecipes(for: primaryFilter.category.apiField, min: primaryFilter.min, max: primaryFilter.max){ [weak self] fetched in
            guard let self = self else { return }
            
            self.recipes = fetched.filter { recipe in
                let meetsNutritionalFilters =  self.filters.allSatisfy { filter in
                    guard let value = self.getNutritionValue(for: filter.category, from: recipe) else{
                        return false
                    }
//                    return value >= Double(filter.min) && value <= Double(filter.max)
                    return value >= (filter.min) && value <= (filter.max)
                }
                let meetsMealCategory = selectedMealsCategory == nil || recipe.category.category == selectedMealsCategory
                return meetsNutritionalFilters && meetsMealCategory
            }
            
        }
    }
    private func getNutritionValue(for category: NutrientCategory, from recipe: RecipeDetails) -> Int?{
        switch category{
        case .protein:
            return recipe.protein_in_grams.map { Int($0) }
        case .fat:
            return recipe.fat_in_grams.map { Int($0) }
//        case .calories: return recipe.calories.map(Double.init)
        case .calories:
            return recipe.calories
        case .carbohydrates:
            return recipe.carbohydrates_in_grams.map { Int($0)}
        }
    }
}

