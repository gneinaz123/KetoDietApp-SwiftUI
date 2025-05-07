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
                        StyledDropdown(selection: $viewModel.selectedCategory) {
                            Label("Nutrient Category", systemImage: "line.horizontal.3.decrease.circle")
                        } content: {
                            ForEach(NutrientCategory.allCases) { category in
                                Text(category.rawValue).tag(category)
                            }
                        }

                        .frame(maxWidth: 400)
                        .padding(.horizontal)

                        // Min / Max inputs + Add button
                        HStack(spacing: 10) {
                            TextField("Min (g)", text: $viewModel.minAmount)
                                    .keyboardType(.numberPad)
                                    .customTextField(placeholder: "Min (g)", text: $viewModel.minAmount)
                                    .onChange(of: viewModel.minAmount) { _ in viewModel.errorMessage = nil }
                                TextField("Max (g)", text: $viewModel.maxAmount)
                                    .keyboardType(.numberPad)
                                    .customTextField(placeholder: "Max (g)", text: $viewModel.maxAmount)
                                    .onChange(of: viewModel.maxAmount) { _ in viewModel.errorMessage = nil }

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
                        
                        if let error = viewModel.errorMessage {
                            Text(error)
                                .foregroundColor(.red)
                                .font(.callout)
                                .padding(.horizontal)
                                .multilineTextAlignment(.center)
                                .lineLimit(nil)
                                .frame(maxWidth: .infinity)
                        }

                        // Meal Category Picker
                        HStack {
                            StyledDropdown(selection: $viewModel.selectedMealCategory) {
                                Label("Meal Category", systemImage: "fork.knife.circle")
                            } content: {
                                ForEach(MealCategory.allCases, id: \.self) { category in
                                    Text(category.rawValue).tag(category)
                                }
                            }


                        }
                        .frame(maxWidth: 550)
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
                            .frame(width: geometry.size.height * 0.2)
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
