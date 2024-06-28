//
//  EpisodesUseCase.swift
//  ListDetailSwiftUI
//
//  Created by Villanueva, Reinaldo on 25/6/24.
//

protocol EpisodesUseCaseType: AutoMockable {
    func getEpisode(byId: Int) async -> Episode?
}

final class EpisodesUseCase: EpisodesUseCaseType {
    
    let repository: EpisodesRepositoryType
    init(repository: EpisodesRepositoryType = EpisodesRepository()) {
        self.repository = repository
    }
    
    func getEpisode(byId id: Int) async -> Episode? {
        do {
            return try await repository.getEpisode(byId: id)?.toEpisode()
        } catch {
            return nil
        }
    }
}
