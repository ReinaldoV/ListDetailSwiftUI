//
//  FavoritesRepository.swift
//  ListDetailSwiftUI
//
//  Created by Villanueva, Reinaldo on 26/6/24.
//

protocol FavoritesRepositoryType: AutoMockable {
    func saveFavorite(favorite: CharacterEntity)
    func loadFavorites() -> [CharacterEntity]
    func deleteFavorite(favorite: CharacterEntity)
}

final class FavoritesRepository: FavoritesRepositoryType {
    
    let dataSource: FavoritesUserDefaultsDataSourceType
    
    init(dataSource: FavoritesUserDefaultsDataSourceType = FavoritesUserDefaultsDataSource()) {
        self.dataSource = dataSource
    }
    
    func saveFavorite(favorite: CharacterEntity) {
        dataSource.saveFavorite(favorite: .init(characterEntity: favorite))
    }
    
    func loadFavorites() -> [CharacterEntity] {
        dataSource.loadFavorites().map { $0.toCharacterEntity() }
    }
    
    func deleteFavorite(favorite: CharacterEntity) {
        dataSource.deleteFavorite(favorite: .init(characterEntity: favorite))
    }
}
