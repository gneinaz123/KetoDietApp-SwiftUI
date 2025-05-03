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
    
    func addFilter(){
        guard let min = Int(minAmount), let max = Int(maxAmount) else{ return }
        let newFilter = Filter(category: selectedCategory, min: min, max: max)
        filters.append(newFilter)
        minAmount = ""
        maxAmount = ""
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
        APIService.shared.fetchRecipes(for: primaryFilter.category.apiField, min: primaryFilter.min, max: primaryFilter.max){ [weak self] fetched in
            guard let self = self else { return }
            
            self.recipes = fetched.filter { recipe in
                self.filters.allSatisfy { filter in
                    guard let value = self.getNutritionValue(for: filter.category, from: recipe) else{
                        return false
                    }
                    return value >= Double(filter.min) && value <= Double(filter.max)
                }
            }
            
        }
    }
    private func getNutritionValue(for category: NutrientCategory, from recipe: RecipeDetails) -> Double?{
        switch category{
        case .protein: return recipe.protein_in_grams
        case .fat: return recipe.fat_in_grams
        case .calories: return recipe.calories.map(Double.init)
        case .carbohydrates: return recipe.carbohydrates_in_grams
        }
    }
}

