//
//  RecentRecipe.swift
//  KetoDietApp-SwiftUI
//
//  Created by user271428 on 5/7/25.
//

import Foundation
import Foundation

extension RecipeDetails {
    static func decodeIngredients(from decoder: Decoder) throws -> [String] {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        return (1...10).compactMap {
            let key = CodingKeys(stringValue: "ingredient_\($0)")!
            return try? container.decodeIfPresent(String.self, forKey: key)
        }
    }
    
    static func decodeMeasurements(from decoder: Decoder) throws -> [Double?] {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        return (1...10).map {
            let key = CodingKeys(stringValue: "measurement_\($0)")!
            return try? container.decodeIfPresent(Double.self, forKey: key)
        }
    }
    
    static func decodeDirections(from decoder: Decoder) throws -> [String] {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        return (1...10).compactMap {
            let key = CodingKeys(stringValue: "directions_step_\($0)")!
            return try? container.decodeIfPresent(String.self, forKey: key)
        }
    }
}








