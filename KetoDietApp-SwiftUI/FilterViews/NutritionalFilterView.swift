//
//  NutritionalFilterView.swift
//  KetoDietApp-SwiftUI
//
//  Created by user271428 on 5/2/25.
//

import SwiftUI

struct NutritionalFilterView: View {
    @StateObject private var viewModel = NutritionalFilterViewModel()
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(alignment: .leading, spacing: 20){
                    Text("Customize your nutritional goals")
                        .font(.headline)
                    
                    Picker("Select Category", selection: $viewModel.selectedCategory){
                        ForEach(NutrientCategory.allCases) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    HStack{
                        TextField("Min (g)", text: $viewModel.minAmount)
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        TextField("Max (g)", text: $viewModel.maxAmount)
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Button("Add"){
                            viewModel.addFilter()
                        }
                        .buttonStyle(.borderedProminent)
                    }
//                    if !viewModel.filters.isEmpty{
                    VStack(alignment: .leading){
                        Text("Active Filters")
                            .font(.subheadline)
                        ForEach(viewModel.filters) { filter in
                            HStack{
                                Text("\(filter.category.rawValue): \(filter.min) - \(filter.max)g")
                                Spacer()
                                Button("Remove"){
                                    viewModel.removeFilters(filter)
                                }
                                .foregroundColor(.red)
                                
                            }
                        }
//                        Button("Search Recipes"){
//                            viewModel.searchRecipes()
//                        }
//                        .padding(.top)
                    }
                    Button("Search Recipes"){
                        viewModel.searchRecipes()
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    if viewModel.isLoading{
                        ProgressView("Loading...")
                    } else{
                        ForEach(viewModel.recipes){ recipe in
                            RecipeCard(recipe: recipe)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Nutritional Filter")
        }
    }
}

#Preview {
    NutritionalFilterView()
}
