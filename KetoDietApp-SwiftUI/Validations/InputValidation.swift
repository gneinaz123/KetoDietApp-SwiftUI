//
//  InputValidation.swift
//  KetoDietApp-SwiftUI
//
//  Created by user271428 on 5/7/25.
//

import Foundation

struct InputValidation {
    
    static func isValidNumber(_ value: String) -> Bool {
        guard let number = Double(value) else { return false }
        return number >= 0
    }

    static func minAmountError(for value: String) -> String? {
        if value.isEmpty {
            return "Min amount cannot be empty."
        } else if !isValidNumber(value) {
            return "Min must be a valid positive number."
        }
        return nil
    }

    static func maxAmountError(for value: String) -> String? {
        if value.isEmpty {
            return "Max amount cannot be empty."
        } else if !isValidNumber(value) {
            return "Max must be a valid positive number."
        }
        return nil
    }

    static func validateRange(min: String, max: String) -> String? {
        guard let minVal = Double(min), let maxVal = Double(max) else {
            return "Both Min and Max must be valid numbers."
        }
        if minVal > maxVal {
            return "Min cannot be greater than Max."
        }
        return nil
    }
}


