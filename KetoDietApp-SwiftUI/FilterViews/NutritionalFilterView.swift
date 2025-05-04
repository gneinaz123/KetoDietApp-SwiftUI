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
                VStack(alignment: .leading, spacing: 16){
                    VStack(alignment: .leading, spacing: 12){
                        HStack{
                            Spacer()
                            Text("Customize your nutritional goals")
                                .font(.headline)
                            Spacer()
                        }
                        
                        HStack{
                            
                            Spacer()
                            Picker("Select Category", selection: $viewModel.selectedCategory){
                                ForEach(NutrientCategory.allCases) { category in
                                    Text(category.rawValue).tag(category)
                                }
                            }
                            //                        .pickerStyle(SegmentedPickerStyle())
                            .pickerStyle(MenuPickerStyle())
                            Spacer()
                        }
                        
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
                        HStack{
                            Picker("Select Meal Category", selection: $viewModel.selectedMealCategory){
                                Text("All").tag(MealCategory?.none)
                                ForEach(MealCategory.allCases, id: \.self){ category in
                                    Text(category.rawValue).tag(Optional(category))
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                        }
                        if !viewModel.filters.isEmpty{
                            VStack(alignment: .leading){
                                Text("Active Filters")
                                    .font(.subheadline)
//                                List{
                                    ForEach(viewModel.filters) { filter in
                                        HStack{
                                            Toggle(isOn: .constant(true)){
                                                Text("\(filter.category.rawValue): \(filter.min) - \(filter.max)g")
                                            }
                                            .disabled(true)
                                            Spacer()
                                            Button("Remove"){
                                                viewModel.removeFilters(filter)
                                            }
                                            .foregroundColor(.red)
                                            
                                        }
                                    }
                                }
                                
                                
                                //                        Button("Search Recipes"){
                                //                            viewModel.searchRecipes()
                                //                        }
                                //                        .padding(.top)
                            }
                        Spacer()
                        HStack{
                            Spacer()
                            Button("Search Recipes"){
                                viewModel.searchRecipes()
                            }
                            .padding()
                            .frame(maxWidth:150)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                            Spacer()
                        }
                            
                        }
                        
                        if viewModel.isLoading{
                            ProgressView("Loading...")
                        } else{
                            VStack(alignment: .leading, spacing: 10){
                                ForEach(viewModel.recipes){ recipe in
                                    RecipeRow(recipe: recipe)
                                    
                                }
                            }
                            
                            .padding(.top)
                            
                        }
                    }
                    .padding()
                
                    
                }
                
                
            }
        .navigationTitle("Nutritional Filter")
            
        }
    }


#Preview {
    NutritionalFilterView()
}
