//
//  HomeView.swift
//  KetoDietApp
//
//  Created by user270107 on 5/2/25.
//

import SwiftUI
import CoreData

struct HomeView: View {
    
    @FetchRequest(
         entity: Goal.entity(),
         sortDescriptors: [NSSortDescriptor(keyPath: \Goal.id, ascending: false)],
         animation: .default
     ) private var savedGoals: FetchedResults<Goal>
     
    
    var body: some View {
        VStack {
            HStack {
                VStack(spacing: -10) {
                    Text("Keto Diet")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.196, green: 0.290, blue: 0.659))

                    Text("APP")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(red: 0.196, green: 0.290, blue: 0.659))
                        .padding(.top, 8)
                }
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)

                Image("logo")
                                    
            }.padding()
            
            // Daily Target Section
            
            BlueBoxText(text: "Your Daily Target").padding(.bottom,30).padding(.top,-10)
            
            if let latestGoal = savedGoals.first {
                            // Replace current values with real consumption logic when ready
                            NutrientProgressRow(label: "Protein", current: 60, goal: latestGoal.protein, unit: "g")
                            NutrientProgressRow(label: "Fat", current: 45, goal: latestGoal.fat, unit: "g")
                            NutrientProgressRow(label: "Carbs", current: 130, goal: latestGoal.carbohydrate, unit: "g")
                            NutrientProgressRow(label: "Calories", current: 1500, goal: latestGoal.calories, unit: "kcal")
                        } else {
                            Text("No saved goals yet.")
                                .foregroundColor(.gray)
                                .padding()
                        }
            
            
                // Today's Recipe Section
            BlueBoxText(text: "Today's Recipe").padding(.top,20).padding(.bottom,10)
                          
            VStack {
                        CardView(text: "Sample Card 1", imageName: "play")
                            .padding(.bottom, 20) //
                    
                    }
                    .padding()
            
            Spacer()
            
        }
    }
    
    
    struct NutrientProgressRow: View {
        var label: String
        var current: Double
        var goal: Double
        var unit: String

        var body: some View {
            let safeCurrent = min(current, goal)

            HStack {
                ProgressView(value: safeCurrent, total: goal) {
                    Text("\(label): \(Int(current)) / \(Int(goal)) \(unit)") .foregroundColor(Color(red: 0.196, green: 0.290, blue: 0.659))                }
                .progressViewStyle(LinearProgressViewStyle(tint: Color(red: 0.196, green: 0.290, blue: 0.659)))
                .frame(height: 20)
                
                Text("\(Int((current / max(goal, 1)) * 100))%") // Avoid division by zero
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
    
    struct CardView: View {
        let text: String
        let imageName: String
        
        var body: some View {
            HStack {
                // Left side: Text
                Text(text)
                    .font(.title2)
                  //  .fontWeight(.bold)
                    .padding(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                // Right side: Image
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100) // Adjust size as needed
                    .clipped()
                    .padding(.trailing)
            }
            .padding()
            .background(Color.white) // Background color of the card
            .cornerRadius(10) // Rounded corners
            .shadow(radius: 2) // Optional: Shadow for card effect
        }
    }


}


#Preview {
    HomeView()
}
