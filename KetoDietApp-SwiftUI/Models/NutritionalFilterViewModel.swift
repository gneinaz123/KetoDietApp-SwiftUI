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
        isLoading = true
        APIService.shared.fetchRecipes(for: filters){ [weak self] recipes in
            self?.recipes = recipes
            self?.isLoading = false
        }
    }
}

