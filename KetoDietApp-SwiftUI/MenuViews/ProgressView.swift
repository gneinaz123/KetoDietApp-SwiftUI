//
//  progressTrackerView.swift
//  KetoDietApp
//
//  Created by user270107 on 5/2/25.
//

import SwiftUI
import CoreData
struct progressTrackerView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
         entity: Goal.entity(),
         sortDescriptors: [NSSortDescriptor(keyPath: \Goal.id, ascending: false)],
         animation: .default
     ) private var savedGoals: FetchedResults<Goal>
     
    @State private var protein = ""
    @State private var fat = ""
    @State private var carbs = ""
    @State private var calories = ""

    var body: some View {
        VStack() {
            BlueBoxText(text: "Daily Progress Tracker")
                .padding(.top, 10)
            
            
            Text("Set Today's Goal").padding(.top,14).fontWeight(.bold)

            VStack{
               
                    HStack {
                    GoalInputField(title: "Protein (mg)", text: $protein)
                    GoalInputField(title: "Fat (g)", text: $fat)
                }
                    
                    HStack {
                        GoalInputField(title: "Carbohydrate (g)", text: $carbs)
                        GoalInputField(title: "Calories (kcal)", text: $calories)
                    }
            
                
                Button(action: {
                    saveGoal()
                }) {
                    Text("Save")
                        .foregroundColor(.white)
                        .padding(10)
                        .frame(maxWidth: 100)
                        .background(Color(red: 0.196, green: 0.290, blue: 0.659))
                        .clipShape(Capsule())
                }.padding(.top, 10)

                    
            }.padding(10)
            BlueBoxText(text: "Progress So far").padding(.vertical,20)
            
         
            if let latestGoal = savedGoals.first {
                // Replace current values with real consumption logic when ready
                NutrientProgressRow(label: "Protein", current: 10, goal: latestGoal.protein, unit: "mg")
                NutrientProgressRow(label: "Fat", current: 30, goal: latestGoal.fat, unit: "g")
                NutrientProgressRow(label: "Carbs", current: 325, goal: latestGoal.carbohydrate, unit: "g")
                NutrientProgressRow(label: "Calories", current: 3000, goal: latestGoal.calories, unit: "kcal")
            } else {
                Text("No saved goals yet.")
                    .foregroundColor(.gray)
                    .padding()
            }

           // .padding()
            
            
            
            
            Spacer()
        }
       // .padding()
        .background(Color.gray.opacity(0.1))
    }
    
    private func saveGoal() {
        let newGoal = Goal(context: viewContext)
        newGoal.id = UUID()
        newGoal.protein = Double(protein) ?? 0.0
        newGoal.fat = Double(fat) ?? 0.0
        newGoal.carbohydrate = Double(carbs) ?? 0.0
        newGoal.calories = Double(calories) ?? 0.0

        do {
            try viewContext.save()
            print("Saved successfully.")
        } catch {
            print("Failed to save goal: \(error.localizedDescription)")
        }
    }
    
    struct NutrientProgressRow: View {
        var label: String
        var current: Double
        var goal: Double
        var unit: String

        var body: some View {
            let safeCurrent = min(current, goal)
            let progressColor = Color(red: 0.196, green: 0.290, blue: 0.659)
            let percentage = Int((goal / max(current, 1)) * 100)

            HStack {
                ProgressView(value: safeCurrent, total: goal) {
                    Text("\(label): \(Int(goal)) / \(Int(current)) \(unit)")

                        .foregroundColor(progressColor)
                }
                .progressViewStyle(LinearProgressViewStyle(tint: progressColor))
                .frame(height: 20)

                Text("\(percentage)%")
                    .font(.subheadline)
                    .padding(3)
                    .frame(width: 50, alignment: .trailing)
                    .bold()
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 30)
        }
    }


    struct GoalInputField: View {
        let title: String
        @Binding var text: String

        var body: some View {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.black)
                TextField("amount", text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .frame(width: 150)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 1)
        }
    }

    struct BlueBoxText: View {
        let text: String

        var body: some View {
            HStack(spacing: 8) {
                Image(systemName: "checkmark")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .regular))

                Text(text)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 14)
            .background(Color(red: 0.196, green: 0.290, blue: 0.659))
            .clipShape(RightCapsuleShape())
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    struct RightCapsuleShape: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            let radius = rect.height / 2
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX - radius, y: rect.minY))
            path.addArc(center: CGPoint(x: rect.maxX - radius, y: rect.midY),
                        radius: radius,
                        startAngle: Angle(degrees: -90),
                        endAngle: Angle(degrees: 90),
                        clockwise: false)
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.closeSubpath()
            return path
        }
    }
}

#Preview {
    progressTrackerView()
}

