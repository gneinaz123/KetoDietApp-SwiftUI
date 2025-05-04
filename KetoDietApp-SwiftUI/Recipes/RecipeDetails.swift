//
//  RecipeDetails.swift
//  KetoDietApp-SwiftUI
//
//  Created by user271428 on 5/2/25.
//

import Foundation

struct RecipeCategory: Codable{
    let id: Int
    let category: String
}
struct RecipeDetails: Identifiable, Decodable{
    let id : Int
    let recipe: String
    let image: String
    let calories: Int?
    let protein_in_grams: Double?
    let fat_in_grams: Double?
    let carbohydrates_in_grams: Double?
    let category : RecipeCategory
}
