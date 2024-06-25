//
//  EpisodeRepository.swift
//  ListDetailSwiftUI
//
//  Created by Villanueva, Reinaldo on 25/6/24.
//

import Combine
import Foundation

protocol EpisodeRepositoryType {
    func callForEpisodes(pageNum: String) async throws -> (episodes: [EpisodeEntity], nextPage: String?)
}

final class EpisodeRepository: EpisodeRepositoryType {
    
    init() {}
    
    func callForEpisodes(pageNum: String) async throws -> (episodes: [EpisodeEntity], nextPage: String?)  {
        let request =  EpisodeListRequest(path: "episode",
                                          queryItems: [URLQueryItem(name: "page",
                                                                    value: pageNum)])
        let service = APIService(baseURL: "https://rickandmortyapi.com/api/")
        
        let response = try await service.call(from: request)
        
        return (episodes: response.results.map { $0.toEpisodeEntity() },
                nextPage: response.info.next?.components(separatedBy: "/").last)
    }
}
