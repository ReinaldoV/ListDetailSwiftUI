//
//  EpisodesRepository.swift
//  ListDetailSwiftUI
//
//  Created by Villanueva, Reinaldo on 25/6/24.
//

import Combine
import Foundation

protocol EpisodesRepositoryType: AutoMockable {
    func getEpisode(byId id: Int) async throws -> EpisodeEntity?
    func callForAllEpisodes() async throws -> [EpisodeEntity]
}

final class EpisodesRepository: EpisodesRepositoryType {
    
    let userDefaultsDataSource: EpisodesUserDefaultsDataSourceType
    let cacheDataSource: EpisodesCacheDataSourceType
    let service: APIServiceType
    
    init(userDefaultsDataSource: EpisodesUserDefaultsDataSourceType = EpisodesUserDefaultsDataSource(),
         cacheDataSource: EpisodesCacheDataSourceType = EpisodesCacheDataSource.shared,
         service: APIServiceType = APIService(baseURL: "https://rickandmortyapi.com/api/")) {
        self.userDefaultsDataSource = userDefaultsDataSource
        self.cacheDataSource = cacheDataSource
        self.service = service
    }
    
    func getEpisode(byId id: Int) async throws -> EpisodeEntity? {
        try await callForAllEpisodes().first { $0.id == id }
    }
    
    func callForAllEpisodes() async throws -> [EpisodeEntity] {
        // 1 - cache
        if let episodes = cacheDataSource.loadEpisodes() {
            return episodes.map { $0.toEpisodeEntity() }
        }
        
        // 2 - Api
        do {
            let episodes = try await loadEpisodesFromApi()
            cacheDataSource.setCache(episodes: episodes)
            return episodes.map { $0.toEpisodeEntity() }
        } catch {
            //3 - UserDefaults
            let episodes = userDefaultsDataSource.loadEpisodes()
            if !episodes.isEmpty {
                cacheDataSource.setCache(episodes: episodes)
                return episodes.map { $0.toEpisodeEntity() }
            }
            throw error
        }
    }
    
    private func loadEpisodesFromApi() async throws -> [EpisodeDTO] {
        var episodes = [EpisodeDTO]()
        
        var (currentEpisodes, nextpage) = try await callForEpisodesToTheAPI(pageNum: "1")
        episodes.append(contentsOf: currentEpisodes)
        
        while nextpage != nil {
            (currentEpisodes, nextpage) = try await callForEpisodesToTheAPI(pageNum: nextpage)
            episodes.append(contentsOf: currentEpisodes)
        }
        
        return episodes
    }
    
    private func callForEpisodesToTheAPI(pageNum: String?) async throws -> (episodes: [EpisodeDTO], nextPage: String?)  {
        let request =  EpisodesListRequest(path: "episode",
                                           queryItems: [URLQueryItem(name: "page",
                                                                     value: pageNum)])
        let response = try await service.call(from: request)
        
        // Save episodes on userDefaults
        self.userDefaultsDataSource.saveEpisodes(episodes: response.results)
        
        return (episodes: response.results,
                nextPage: response.info.next?.components(separatedBy: "=").last)
    }
}
