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
    private let character: Character
    
    init(episodesUseCase: EpisodesUseCaseType = EpisodesUseCase.shared, character: Character) {
        self.episodesUseCase = episodesUseCase
        self.character = character
    }
    
    func loadEpisodes() {
        print(episodes)
        episodes.append(contentsOf: character.episodes.compactMap({ episodesUseCase.getEpisode(byId: $0) }))
        print(episodes)
    }
}
