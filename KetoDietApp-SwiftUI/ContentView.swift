//
//  ContentView.swift
//  KetoDietApp
//
//  Created by user270107 on 5/1/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        VStack {
            if UIDevice.current.userInterfaceIdiom == .pad {
                // iPad Layout: Sidebar Navigation
                NavigationSplitView {
                    List {
                        NavigationLink(destination: HomeView()) {
                            Label("Home", systemImage: "house")
                        }
                        NavigationLink(destination:
                                NutritionalFilterView()) {
                            Label("Recipe", systemImage:"heart")
                        }
                        NavigationLink(destination: SavedRecipesView()) {
                            Label("Recipe", systemImage:"bell")
                        }
                        NavigationLink(destination: progressTrackerView()) {
                            Label("Recipe", systemImage:"play")
                        }                }
                    .listStyle(SidebarListStyle())
                    .navigationTitle("Menu")
                    
                } detail: {
                    HomeView() // Default detail view
                }
            } else {
                // iPhone Layout: Tab Bar
                TabView {
                    HomeView()
                        .tabItem {
                            Label("Home", systemImage: "house")
                        }
                    
                    NutritionalFilterView()
                        .tabItem {
                            Label("Recipe", systemImage: "heart")
                        }
                    
                    SavedRecipesView()
                        .tabItem{Label("Planner", systemImage: "bell")}
                    
                    progressTrackerView()
                        .tabItem{
                            Label("Progress",systemImage: "play")
                        }
                }
                .accentColor(Color(red: 0.196, green: 0.290, blue: 0.659))
                
            }
            
        }
        
    }
    
    
}



#Preview {
    ContentView()
}
