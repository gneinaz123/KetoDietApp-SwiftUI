//
//  HomeView.swift
//  KetoDietApp
//
//  Created by user270107 on 5/2/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Keto Diet APP")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.196, green: 0.290, blue: 0.659))
                Spacer()
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                
            }.padding()
            
            // Daily Target Section
            
            BlueBoxText(text: "Your Daily Target")
            
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
            
                // Today's Recipe Section
            BlueBoxText(text: "Today's Recipe")
                          
            VStack {
                        CardView(text: "Sample Card 1", imageName: "play")
                            .padding(.bottom, 20) //
                    
                    }
                    .padding()
            
            Spacer()
            
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
