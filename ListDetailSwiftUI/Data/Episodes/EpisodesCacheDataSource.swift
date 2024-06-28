//
//  EpisodesCacheDataSource.swift
//  ListDetailSwiftUI
//
//  Created by Villanueva, Reinaldo on 26/6/24.
//

import Foundation

protocol EpisodesCacheDataSourceType: AutoMockable {
    func setCache(episodes: [EpisodeDTO])
    func loadEpisodes() -> [EpisodeDTO]?
}

final class EpisodesCacheDataSource: EpisodesCacheDataSourceType {
    
    private var episodes: [EpisodeDTO]?
    private var timeToExpireCache = Date.now
    
    static var shared = EpisodesCacheDataSource()
    
    private init() {}
    
    func setCache(episodes: [EpisodeDTO]) {
        self.episodes = episodes
        self.timeToExpireCache = Date.now.addingTimeInterval(15 * 60) //15 minutes
    }
    
    func loadEpisodes() -> [EpisodeDTO]? {
        if timeToExpireCache < Date.now {
            episodes = nil
        }
        return episodes
    }
}
