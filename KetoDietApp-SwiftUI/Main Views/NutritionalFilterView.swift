//
//  NutritionalFilterView.swift
//  KetoDietApp-SwiftUI
//
//  Created by user271428 on 5/2/25.
//
import SwiftUI

struct NutritionalFilterView: View {
    @EnvironmentObject var viewModel: NutritionalFilterViewModel

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ScrollView {
                    VStack(alignment: .center, spacing: 20) {
                        
                        Text("Customize Your Nutritional Goals")
                            .font(.title3)
                            .bold()
                            .multilineTextAlignment(.center)
                            .padding(.top)

                        // Nutrient Category Picker
                        HStack {
                            Picker("Select Category", selection: $viewModel.selectedCategory) {
                                ForEach(NutrientCategory.allCases) { category in
                                    Text(category.rawValue).tag(category)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                            )
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)

                        // Min / Max inputs + Add button
                        HStack(spacing: 10) {
                            TextField("Min (g)", text: $viewModel.minAmount)
                                    .keyboardType(.numberPad)
                                    .customTextField(placeholder: "Min (g)", text: $viewModel.minAmount)
                                TextField("Max (g)", text: $viewModel.maxAmount)
                                    .keyboardType(.numberPad)
                                    .customTextField(placeholder: "Max (g)", text: $viewModel.maxAmount)

                            Button("Add") {
                                viewModel.addFilter()
                            }
                            .padding(.vertical, 16)
                            .padding(.horizontal, 19)
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            
                        }
                        .padding(.horizontal)

                        // Meal Category Picker
                        HStack {
                            Picker("Select Meal Category", selection: $viewModel.selectedMealCategory) {
                                Text("All").tag(MealCategory?.none)
                                ForEach(MealCategory.allCases, id: \.self) { category in
                                    Text(category.rawValue).tag(Optional(category))
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                            )
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)

                        // Active Filters
                        if !viewModel.filters.isEmpty {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Active Filters")
                                    .font(.subheadline)
                                    .bold()

                                ForEach(viewModel.filters) { filter in
                                    HStack {
                                        Toggle(isOn: .constant(true)) {
                                            Text("\(filter.category.rawValue): \(filter.min) - \(filter.max)g")
                                        }
                                        .disabled(true)

                                        Spacer()

                                        Button("Remove") {
                                            viewModel.removeFilters(filter)
                                        }
                                        .foregroundColor(.red)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }

                        // Search Button
                        HStack {
                            Spacer()
                            Button("Search Recipes") {
                                viewModel.searchRecipes()
                            }
                            .padding(.vertical, 20)
                            .padding(.horizontal, 20)
                            .frame(width: geometry.size.width * 0.2)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                            Spacer()
                        }

                        // Loading / Results
                        if viewModel.isLoading {
                            ProgressView("Loading...")
                                .padding()
                        } else {
                            LazyVStack(alignment: .leading, spacing: 12) {
                                ForEach(viewModel.recipes) { recipe in
                                    RecipeRow(recipe: recipe)
                                }
                            }
                            .padding(.horizontal)
                        }

                    }
                    .padding(.bottom)
                }
            }
        }
        .navigationTitle("Nutritional Filter")
    }
}

struct NutritionalFilterView_Previews: PreviewProvider {
    static var previews: some View {
        NutritionalFilterView()
            .environmentObject(NutritionalFilterViewModel())
    }
}
