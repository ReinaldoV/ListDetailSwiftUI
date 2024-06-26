//
//  FavoritesUseCase.swift
//  ListDetailSwiftUI
//
//  Created by Villanueva, Reinaldo on 26/6/24.
//

protocol FavoritesUseCaseType {
    func saveFavorite(favorite: Character)
    func loadFavorites() -> [Character]
    func deleteFavorite(favorite: Character)
}

final class FavoritesUseCase: FavoritesUseCaseType {
    
    let repository: FavoritesRepositoryType
    
    init(repository: FavoritesRepositoryType = FavoritesRepository()) {
        self.repository = repository
    }
    
    
    func saveFavorite(favorite: Character) {
        repository.saveFavorite(favorite: .init(character: favorite))
    }
    
    func loadFavorites() -> [Character] {
        repository.loadFavorites().map { $0.toCharacter() }
    }
    
    func deleteFavorite(favorite: Character) {
        repository.deleteFavorite(favorite: .init(character: favorite))
    }
}
