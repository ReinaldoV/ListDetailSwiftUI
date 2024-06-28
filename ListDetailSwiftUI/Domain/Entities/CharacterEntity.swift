//
//  CharacterEntity.swift
//  ListDetailSwiftUI
//
//  Created by Villanueva, Reinaldo on 24/6/24.
//

struct CharacterEntity: Equatable {
    
    init(id: Int, 
         name: String,
         status: StatusEntity,
         species: String,
         origin: String,
         location: String,
         episodes: [Int],
         image: String) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.origin = origin
        self.location = location
        self.episodes = episodes
        self.image = image
    }
    
    init(character: Character) {
        self.init(id: character.id,
                  name: character.name,
                  status: StatusEntity.getFrom(character.status),
                  species: character.species,
                  origin: character.origin,
                  location: character.location,
                  episodes: character.episodes,
                  image: character.image)
    }
    
    var id: Int
    var name: String
    var status: StatusEntity
    var species: String
    var origin: String
    var location: String
    var episodes: [Int]
    var image: String
}

extension CharacterEntity {
    func toCharacter() -> Character {
        Character(id: self.id,
                  name: self.name,
                  status: self.status.toStatus(),
                  species: self.species,
                  image: self.image,
                  origin: self.origin,
                  location: self.location,
                  episodes: self.episodes)
    }
}

enum StatusEntity {
    case alive
    case dead
    case unknown
    
    func toStatus() -> Status {
        switch self {
        case .alive:
            return .alive
        case .dead:
            return .dead
        case .unknown:
            return .unknown
        }
    }
    
    static func getFrom(_ status: Status) -> StatusEntity {
        switch status {
        case .alive:
            return .alive
        case .dead:
            return .dead
        case .unknown:
            return .unknown
        }
    }
}
