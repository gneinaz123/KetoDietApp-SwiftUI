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
            VStack(alignment: .leading) {                ProgressView(value: 0.75) {
                    Text("Calories: 1500 / 2000 kcal")
                }
                
            }
            .padding()
            
            // Today's Recipe Section
            VStack(alignment: .leading) {
                Text("Today's Recipe")
                    .font(.title2)
                    .fontWeight(.semibold)
                Image("morning_salad") // Replace with actual image asset name
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Text("Morning Salad")
                    .font(.title3)
                    .fontWeight(.medium)
            }
            .padding()
            
            Spacer()
            
        }
    }
    struct BlueBoxText: View {
        let text: String
        var body: some View {
            ZStack {
                Rectangle()
                   .cornerRadius(10)
                   .foregroundColor(Color(red: 0.196, green: 0.290, blue: 0.659))  .frame(height: 50) // Adjust height as needed
                Text(text)
                   .font(.title2)
                   .fontWeight(.semibold)
                   .foregroundColor(.white)
                   //.padding(.vertical, 10)
            }
            
        }
    }
}


#Preview {
    HomeView()
}
