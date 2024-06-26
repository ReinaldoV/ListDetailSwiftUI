//
//  EpisodesUserDefaultsDataSource.swift
//  ListDetailSwiftUI
//
//  Created by Villanueva, Reinaldo on 25/6/24.
//

import Foundation

protocol EpisodesUserDefaultsDataSourceType {
    func saveEpisodes(episodes: [EpisodeDTO])
    func loadEpisodes() -> [EpisodeDTO]
    func deleteEpisodes()
}

final class EpisodesUserDefaultsDataSource: EpisodesUserDefaultsDataSourceType {

    let episodesKey = "episodesKey"

    func saveEpisodes(episodes: [EpisodeDTO]) {
        let previousEpisodes = loadEpisodes()
        let allEpisodes = previousEpisodes + episodes
        let data = allEpisodes.map { try? JSONEncoder().encode($0) }
        let defaults = UserDefaults.standard
        defaults.set(data, forKey: self.episodesKey)
    }

    func loadEpisodes() -> [EpisodeDTO] {
        let defaults = UserDefaults.standard
        guard let encodedData = defaults.array(forKey: self.episodesKey) as? [Data] else {
            return [EpisodeDTO]()
        }

        return encodedData.map { try! JSONDecoder().decode(EpisodeDTO.self, from: $0) }
    }

    func deleteEpisodes() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: episodesKey)
    }
}
