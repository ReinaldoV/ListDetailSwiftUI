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

struct CharacterDTO: Codable {
    
    init(id: Int, 
         name: String,
         status: StatusDTO,
         species: String,
         origin: LocationDTO,
         location: LocationDTO,
         episode: [String],
         image: String) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.origin = origin
        self.location = location
        self.episode = episode
        self.image = image
    }
    
    init(characterEntity: CharacterEntity) {
        self.init(id: characterEntity.id,
                  name: characterEntity.name,
                  status: StatusDTO.getStatusDTO(from: characterEntity.status),
                  species: characterEntity.species,
                  origin: .init(name: characterEntity.origin),
                  location: .init(name: characterEntity.location),
                  episode: characterEntity.episodes.map { $0.description },
                  image: characterEntity.image)
    }
    
    var id: Int
    var name: String
    var status: StatusDTO
    var species: String
    var origin: LocationDTO
    var location: LocationDTO
    var episode: [String]
    var image: String
}

struct LocationDTO: Codable {
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
    
    static func getStatusDTO(from statusEntity: StatusEntity) -> StatusDTO {
        switch statusEntity {
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
