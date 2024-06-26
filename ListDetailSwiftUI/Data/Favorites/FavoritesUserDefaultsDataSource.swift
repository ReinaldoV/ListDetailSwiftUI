//
//  FavoritesUserDefaultsDataSource.swift
//  ListDetailSwiftUI
//
//  Created by Villanueva, Reinaldo on 26/6/24.
//

import Foundation

protocol FavoritesUserDefaultsDataSourceType {
    func saveFavorite(favorite: CharacterDTO)
    func loadFavorites() -> [CharacterDTO]
    func deleteFavorite(favorite: CharacterDTO)
}

class FavoritesUserDefaultsDataSource: FavoritesUserDefaultsDataSourceType {
    
    let favoritesKey = "favoritesKey"
    
    func saveFavorite(favorite: CharacterDTO) {
        var favoritesEpisodes = loadFavorites()
        favoritesEpisodes.append(favorite)
        saveFavorites(favorites: favoritesEpisodes)
    }
    
    func loadFavorites() -> [CharacterDTO] {
        let defaults = UserDefaults.standard
        guard let encodedData = defaults.array(forKey: self.favoritesKey) as? [Data] else {
            return [CharacterDTO]()
        }
        
        return encodedData.map { try! JSONDecoder().decode(CharacterDTO.self, from: $0) }
            .sorted { $0.id < $1.id }
    }
    
    func deleteFavorite(favorite: CharacterDTO) {
        var favoritesEpisodes = loadFavorites()
        favoritesEpisodes.removeAll { $0.id == favorite.id }
        saveFavorites(favorites: favoritesEpisodes)
    }
    
    private func saveFavorites(favorites: [CharacterDTO]) {
        let data = favorites.map { try? JSONEncoder().encode($0) }
        let defaults = UserDefaults.standard
        defaults.set(data, forKey: self.favoritesKey)
    }
}
