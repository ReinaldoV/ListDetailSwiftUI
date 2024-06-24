//
//  CharactersDataSource.swift
//  ListDetailSwiftUI
//
//  Created by Villanueva, Reinaldo on 24/6/24.
//

import Foundation

struct CharacterListRequest: APIRequestType {
    typealias ModelType = CharacterListDTO
    
    var path: String
    var method: String { return "GET" }
    var headers: [String: String]? { return ["Content-Type": "application/json"] }
    var queryItems: [URLQueryItem]?
    func body() throws -> Data? {
        return Data()
    }
}

struct CharacterListDTO: Decodable {
    var info: InfoDTO
    var results: [CharacterDTO]
}

struct InfoDTO: Decodable {
    var count: Int
    var pages: Int
    var next: String?
    var prev: String?
}

extension InfoDTO {
    func toResponseInfoEntity() -> ResponseInfoEntity {
        return ResponseInfoEntity(count: self.count,
                                  pages: self.pages,
                                  next: self.next,
                                  prev: self.prev)
    }
}

struct CharacterDTO: Decodable {
    var id: Int
    var name: String
    var status: StatusDTO
    var species: String
    var image: String
}

enum StatusDTO: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown
    
    func toStatus() -> StatusEntity {
        switch self {
        case .alive:
            return .alive
        case .dead:
            return .dead
        case .unknown:
            return .unknown
        }
    }
}

extension CharacterDTO {
    func toCharacterEntity() -> CharacterEntity {
        return CharacterEntity(id: self.id,
                               name: self.name,
                               status: self.status.toStatus(),
                               species: self.species,
                               image: self.image)
    }
}

