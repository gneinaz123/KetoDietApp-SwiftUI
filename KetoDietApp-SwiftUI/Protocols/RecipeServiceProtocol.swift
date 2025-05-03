//
//  RecipeServiceProtocol.swift
//  KetoDietApp-SwiftUI
//
//  Created by user271428 on 5/2/25.
//

import Foundation

protocol RecipeServiceProtocol{
    //func fetchRecipes(for filters: [Filter], completion: @escaping ([RecipeDetails]) -> Void)
    func fetchRecipes(for field: String, min: Int, max: Int, completion: @escaping ([RecipeDetails]) -> Void)
}
