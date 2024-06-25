//
//  EpisodeRepository.swift
//  ListDetailSwiftUI
//
//  Created by Villanueva, Reinaldo on 25/6/24.
//

import Combine
import Foundation

protocol EpisodeRepositoryType {
    func callForAllEpisodes() async throws -> [EpisodeEntity]
}

final class EpisodeRepository: EpisodeRepositoryType {
    
    init() {}
    
    func callForAllEpisodes() async throws -> [EpisodeEntity] {        
        return try await loadEpisodesFromApi()
    }
    
    private func loadEpisodesFromApi() async throws -> [EpisodeEntity] {
        var episodes = [EpisodeEntity]()
        
        var (currentEpisodes, nextpage) = try await callForEpisodesToTheAPI(pageNum: "1")
        episodes.append(contentsOf: currentEpisodes)
        
        while nextpage != nil {
            (currentEpisodes, nextpage) = try await callForEpisodesToTheAPI(pageNum: nextpage)
            episodes.append(contentsOf: currentEpisodes)
        }
        
        return episodes
    }
    
    private func callForEpisodesToTheAPI(pageNum: String?) async throws -> (episodes: [EpisodeEntity], nextPage: String?)  {
        let request =  EpisodeListRequest(path: "episode",
                                          queryItems: [URLQueryItem(name: "page",
                                                                    value: pageNum)])
        let service = APIService(baseURL: "https://rickandmortyapi.com/api/")
        
        let response = try await service.call(from: request)
        
        return (episodes: response.results.map { $0.toEpisodeEntity() },
                nextPage: response.info.next?.components(separatedBy: "=").last)
    }
}
