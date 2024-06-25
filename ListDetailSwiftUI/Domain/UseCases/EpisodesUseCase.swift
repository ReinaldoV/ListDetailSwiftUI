//
//  EpisodesUseCase.swift
//  ListDetailSwiftUI
//
//  Created by Villanueva, Reinaldo on 25/6/24.
//

protocol EpisodesUseCaseType {
    func getEpisode(byId: Int) -> Episode?
}

final class EpisodesUseCase: EpisodesUseCaseType {
    
    let repository: EpisodeRepositoryType
    var episodes = [EpisodeEntity]()
    
    static var shared: EpisodesUseCase = {
        let useCase = EpisodesUseCase()
        Task {
            do {
                useCase.episodes = try await useCase.repository.callForAllEpisodes()
                print(useCase.episodes)
            } catch {
                print("Error while retrieving the episodes")
            }
        }
        return useCase
    }()
    
    private init(repository: EpisodeRepositoryType = EpisodeRepository()) {
        self.repository = repository
    }
    
    func getEpisode(byId id: Int) -> Episode? {
        episodes.first { $0.id == id }?.toEpisode()
    }
}
