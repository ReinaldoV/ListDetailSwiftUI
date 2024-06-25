//
//  CharacterDTO.swift
//  ListDetailSwiftUI
//
//  Created by Villanueva, Reinaldo on 25/6/24.
//

struct CharacterListDTO: Decodable {
    var info: InfoDTO
    var results: [CharacterDTO]
}

struct CharacterDTO: Decodable {
    var id: Int
    var name: String
    var status: StatusDTO
    var species: String
    var origin: LocationDTO
    var location: LocationDTO
    var episode: [String]
    var image: String
}

struct LocationDTO: Decodable {
    var name: String
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
                               origin: self.origin.name,
                               location: self.location.name,
                               episodes: self.episode.compactMap { Int($0.components(separatedBy: "/").last ?? "") },
                               image: self.image)
    }
}
