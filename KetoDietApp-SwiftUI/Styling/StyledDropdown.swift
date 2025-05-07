//
//  StyledDropdown.swift
//  KetoDietApp-SwiftUI
//
//  Created by user271428 on 5/7/25.
//

import SwiftUI
struct StyledDropdown<SelectionValue: Hashable, Label: View, Content: View>: View {
    let label: () -> Label
    let selection: Binding<SelectionValue>
    let content: () -> Content

    init(selection: Binding<SelectionValue>,
         @ViewBuilder label: @escaping () -> Label,
         @ViewBuilder content: @escaping () -> Content) {
        self.selection = selection
        self.label = label
        self.content = content
    }

    var body: some View {
        HStack {
            label()
                .foregroundColor(.gray)

            Picker("", selection: selection) {
                content()
            }
            .pickerStyle(MenuPickerStyle())
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
        }
        .padding(.horizontal, 14)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(UIColor.systemGray6))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.accentColor.opacity(0.4), lineWidth: 1)
        )
        .hoverEffect(.highlight)
        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
        .padding(.horizontal)
    }
}

