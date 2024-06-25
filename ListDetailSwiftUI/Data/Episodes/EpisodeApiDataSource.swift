//
//  EpisodeApiDataSource.swift
//  ListDetailSwiftUI
//
//  Created by Villanueva, Reinaldo on 25/6/24.
//

import Foundation

struct EpisodeListRequest: APIRequestType {
    typealias ModelType = EpisodesListDTO
    
    var path: String
    var method: String { return "GET" }
    var headers: [String: String]? { return ["Content-Type": "application/json"] }
    var queryItems: [URLQueryItem]?
    func body() throws -> Data? {
        return Data()
    }
}

struct EpisodesListDTO: Decodable {
    var info: InfoDTO
    var results: [EpisodeDTO]
}

struct EpisodeDTO: Decodable {
    var id: Int
    var name: String
    var airDate: String
    var episode: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case airDate = "air_date"
        case episode
    }
}

extension EpisodeDTO {
    func toEpisodeEntity() -> EpisodeEntity {
        EpisodeEntity(id: self.id,
                      name: self.name,
                      airDate: self.airDate,
                      episode: self.episode)
    }
}
