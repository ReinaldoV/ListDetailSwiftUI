//
//  CharacterEntity.swift
//  ListDetailSwiftUI
//
//  Created by Villanueva, Reinaldo on 24/6/24.
//

struct CharacterEntity {
    var id: Int
    var name: String
    var status: StatusEntity
    var species: String
    var image: String
}

extension CharacterEntity {
    func toCharacter(isFavorite: Bool = false) -> Character {
        Character(id: self.id,
                  name: self.name,
                  status: self.status.toStatus(),
                  species: self.species,
                  image: self.image,
                  isFavorite: isFavorite)
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
}
