//
//  ContentView.swift
//  ListDetailSwiftUI
//
//  Created by Villanueva, Reinaldo on 24/6/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedIndex: Int = 0

    var body: some View {
        TabView(selection: $selectedIndex) {
            NavigationStack() {
                CharactersListView()
            }
            .tabItem {
                Text("Explore")
                Image(systemName: "magnifyingglass")
                    .renderingMode(.template)
            }
            .tag(0)
            
            NavigationStack() {
                FavoritesView()
                    .navigationTitle("Your Favorites")
            }
            .tabItem {
                Label("Your Favorites", systemImage: "heart.fill")
            }
            .tag(1)
        }
        .tint(.green)
        .onAppear(perform: {
            UITabBar.appearance().unselectedItemTintColor = .systemBrown
            UITabBar.appearance().backgroundColor = .systemGray4.withAlphaComponent(0.4)
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.systemGreen]
        })
    }
}
