//
//  CleanAmount.swift
//  KetoDietApp-SwiftUI
//
//  Created by user271428 on 5/7/25.
//

import Foundation

extension Double {
    var cleanAmount: String {
        return truncatingRemainder(dividingBy: 1) == 0 ? String(Int(self)) : String(self)
    }
}
