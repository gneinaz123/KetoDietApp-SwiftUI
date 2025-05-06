//
//  NutritionalFilterValidator.swift
//  KetoDietApp-SwiftUI
//
//  Created by user271428 on 5/7/25.
//

import Foundation

struct NutritionalFilterValidator {
    static func validate(minText: String, maxText: String) -> (min: Int?, max: Int?, error: String?) {
        guard !minText.isEmpty, !maxText.isEmpty else {
            return (nil, nil, "Both fields are required.")
        }

        guard let min = Int(minText), let max = Int(maxText) else {
            return (nil, nil, "Only numbers are allowed.")
        }

        guard min >= 0, max >= 0 else {
            return (nil, nil, "Negative values are not allowed.")
        }
        
        guard min <= max else {
            return (nil, nil, "Min must be less than or equal to Max.")
        }

        return (min, max, nil)
    }
}

