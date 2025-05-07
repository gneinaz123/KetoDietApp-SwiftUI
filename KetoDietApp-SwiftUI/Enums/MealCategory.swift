//
//  mealCategory.swift
//  KetoDietApp-SwiftUI
//
//  Created by user271428 on 5/4/25.
//

import Foundation

enum MealCategory: String, CaseIterable, Identifiable {
    case all = "All"
    case breakfast = "Breakfast Recipes"
    case Appetizer = "Appetizer and Snacks Recipes"
    case beef = "Beef Recipes"
    case pork = "Pork And Other Red Meat"
    case poultry = "Poultry Recipes"
    case fish = "Fish and Seafood Recipes"
    case soups = "Soups and Stews Recipes"
    case desserts = "Desserts Recipes"
    case vegan = "Vegan and Vegetarian Recipes"
    case staplesDips = "Keto Kitchen Staples And Dips Recipes"
    case drinks = "Drinks And Smoothies"
    
    
    var id: String {self.rawValue}
    
}
