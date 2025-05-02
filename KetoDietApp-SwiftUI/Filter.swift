//
//  Filter.swift
//  KetoDietApp-SwiftUI
//
//  Created by user271428 on 5/2/25.
//

import Foundation

struct Filter: Identifiable, Hashable{
    let id = UUID()
    var category: NutrientCategory
    var min: Int
    var max: Int
}
