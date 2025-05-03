//
//  progressTrackerView.swift
//  KetoDietApp
//
//  Created by user270107 on 5/2/25.
//

import SwiftUI

struct progressTrackerView: View {
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
                    GoalInputField(title: "Protein (g)", text: $protein)
                    GoalInputField(title: "Fat (g)", text: $fat)
                }
                    
                    HStack {
                        GoalInputField(title: "Carbohydrate (g)", text: $carbs)
                        GoalInputField(title: "Calories (kcal)", text: $calories)
                    }
            
                
                Button(action: {
                    // Save logic here
                    print("Saved goals: P: \(protein), F: \(fat), C: \(carbs), Cal: \(calories)")
                }) {
                    Text("Save")
                        .foregroundColor(.white)
                        .padding(10)
                        .frame(maxWidth: 100)
                       // .background(Color.blue)
                        .background(Color(red: 0.196, green: 0.290, blue: 0.659))                        .clipShape(Capsule())
                }.padding(.top,10 )
                    
            }.padding(10)
            BlueBoxText(text: "Progress So far").padding(.top,20)
            
            HStack {
                // Progress bar
                ProgressView(value: 20){
                    // Percentage label
                    Text("Calories: 1500 / 2000 kcal")
                } .progressViewStyle(LinearProgressViewStyle(tint: Color(red: 0.196, green: 0.290, blue: 0.659)))
                    .frame(height: 20)
                
                // Percentage label
                Text("\(Int(1 * 100))%")
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
            .padding(10)
            .padding()
            
            
            
            
            Spacer()
        }
       // .padding()
        .background(Color.gray.opacity(0.1))
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
