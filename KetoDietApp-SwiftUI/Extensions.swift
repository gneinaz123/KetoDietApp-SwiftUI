//
//  Extensions.swift
//  KetoDietApp-SwiftUI
//
//  Created by user271428 on 5/4/25.
//

import Foundation

extension Array{
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
