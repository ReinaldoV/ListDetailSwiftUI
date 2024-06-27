//
//  CharacterDetailViewModel.swift
//  ListDetailSwiftUI
//
//  Created by Villanueva, Reinaldo on 25/6/24.
//

import Foundation

final class CharacterDetailViewModel: ObservableObject {
    
    @Published var episodes: [Episode] = []
    
    private let episodesUseCase: EpisodesUseCaseType
    private let favoritesUseCase: FavoritesUseCaseType
    private let character: Character
    
    init(episodesUseCase: EpisodesUseCaseType = EpisodesUseCase(),
         favoritesUseCase: FavoritesUseCaseType = FavoritesUseCase(),
         character: Character) {
        self.episodesUseCase = episodesUseCase
        self.favoritesUseCase = favoritesUseCase
        self.character = character
    }
    
    func loadEpisodes() {
        for episodeId in character.episodes {
            Task {
                if let episode = await episodesUseCase.getEpisode(byId: episodeId){
                    await MainActor.run {
                        self.episodes.append(episode)
                        episodes.sort { $0.id < $1.id}
                    }
                }
            }
        }
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
