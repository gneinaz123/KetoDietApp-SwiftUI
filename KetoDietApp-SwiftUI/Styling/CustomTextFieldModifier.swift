//
//  CustomTextFieldModifier.swift
//  KetoDietApp-SwiftUI
//
//  Created by user271428 on 5/7/25.
//

import SwiftUI

struct CustomTextFieldModifier: ViewModifier {
    var placeholder: String
    @Binding var text: String

    func body(content: Content) -> some View {
        content
            .padding(.vertical, 10)
            .padding(.horizontal, 12)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.4), lineWidth: 1))
            .placeholder(when: text.isEmpty) {
                HStack{
                    Text(placeholder)
                        .foregroundColor(.gray)
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 4)
                }
            }
        
    }
}

extension View {
    func customTextField(placeholder: String, text: Binding<String>) -> some View {
        self.modifier(CustomTextFieldModifier(placeholder: placeholder, text: text))
    }
}

