//
//  NutrientCategory.swift
//  KetoDietApp-SwiftUI
//
//  Created by user271428 on 5/2/25.
//

import Foundation

enum NutrientCategory: String, CaseIterable, Identifiable{
    case protein = "Protein"
    case fat = "Fats"
    case carbohydrates = "Carbohydrates"
    case calories = "Calories"
    
    var id: String {self.rawValue}
    
    var apiField: String{
        switch self{
        case .protein: return "protein_in_grams"
        case .fat: return "fat_in_grams"
        case .carbohydrates: return "carbohydrates_in_grams"
        case .calories: return "calories"
            
        }
    }
    
}
