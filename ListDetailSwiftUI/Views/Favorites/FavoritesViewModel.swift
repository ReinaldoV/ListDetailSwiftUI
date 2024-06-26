//
//  FavoritesViewModel.swift
//  ListDetailSwiftUI
//
//  Created by Villanueva, Reinaldo on 26/6/24.
//

import Foundation

final class FavoritesViewModel: ObservableObject {
    
    @Published var characters: [Character] = []
    
    init() {
    }
}
