//
//  EpisodeEntity.swift
//  ListDetailSwiftUI
//
//  Created by Villanueva, Reinaldo on 25/6/24.
//

struct EpisodeEntity {
    var id: Int
    var name: String
    var airDate: String
    var episode: String
}

extension EpisodeEntity {
    func toEpisode() -> Episode {
        Episode(id: self.id,
                name: self.name,
                airDate: self.airDate,
                episode: self.episode)
    }
}
