//
//  FavoritesViewModel.swift
//  ListDetailSwiftUI
//
//  Created by Villanueva, Reinaldo on 26/6/24.
//

import Foundation

final class FavoritesViewModel: ObservableObject {
    
    @Published var characters: [Character] = []
    
    private let favoritesUseCase: FavoritesUseCaseType
    
    init(favoritesUseCase: FavoritesUseCaseType = FavoritesUseCase()) {
        self.favoritesUseCase = favoritesUseCase
    }
    
    func refreshFavorites() {
        self.characters = favoritesUseCase.loadFavorites()
    }
    
    func isFavorite(character: Character) -> Bool {
        favoritesUseCase.isFavorite(favorite: character)
    }
    
    func updateFavorite(character: Character) -> Bool {
        if isFavorite(character: character) {
            favoritesUseCase.deleteFavorite(favorite: character)
            return false
        } else {
            favoritesUseCase.saveFavorite(favorite: character)
            return true
        }
    }
}
