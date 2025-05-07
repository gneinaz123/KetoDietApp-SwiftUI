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
    let image: String?
    let calories: Int?
    let protein_in_grams: Double?
    let fat_in_grams: Double?
    let carbohydrates_in_grams: Double?
    let category : RecipeCategory
    
    let ingredients: [String]
    let measurements: [Double?]
    let directions: [String]
    
    enum CodingKeys: String, CodingKey{
        case id, recipe, category, calories,protein_in_grams,fat_in_grams, carbohydrates_in_grams, image
        
        case ingredient_1, ingredient_2, ingredient_3, ingredient_4, ingredient_5,
             ingredient_6, ingredient_7, ingredient_8, ingredient_9, ingredient_10
        
        case measurement_1, measurement_2, measurement_3, measurement_4, measurement_5,
             measurement_6, measurement_7, measurement_8, measurement_9, measurement_10

        case directions_step_1, directions_step_2, directions_step_3, directions_step_4, directions_step_5,
             directions_step_6, directions_step_7, directions_step_8, directions_step_9, directions_step_10
        
    }
    init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        recipe = try container.decode(String.self, forKey: .recipe)
        calories = try? container.decode(Int.self, forKey: .calories)
        protein_in_grams = try? container.decode(Double.self, forKey: .protein_in_grams)
        fat_in_grams = try? container.decode(Double.self, forKey: .fat_in_grams)
        carbohydrates_in_grams = try? container.decode(Double.self, forKey: .carbohydrates_in_grams)
        image = try? container.decode(String.self, forKey: .image)
        category = try container.decode(RecipeCategory.self, forKey: .category)
        ingredients = (1...10).compactMap{
            let key = CodingKeys(stringValue: "ingredient_\($0)")!
            return try? container.decodeIfPresent(String.self, forKey: key)
        }
        measurements = (1...10).map {
            let key = CodingKeys(stringValue: "measurement_\($0)")!
            return try? container.decodeIfPresent(Double.self, forKey: key)
        }

        directions = (1...10).compactMap {
            let key = CodingKeys(stringValue: "directions_step_\($0)")!
            return try? container.decodeIfPresent(String.self, forKey: key)
        }
        
    }
}
