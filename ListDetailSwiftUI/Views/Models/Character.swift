//
//  CharacterDisplaymodel.swift
//  ListDetailSwiftUI
//
//  Created by Villanueva, Reinaldo on 24/6/24.
//

struct Character: Identifiable {
    var id: Int
    var name: String
    var status: Status
    var species: String
    var image: String
    var location: String
    var numberFirstEpisode: String
    var isFavorite: Bool = false
}

enum Status: String {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "Unknown"
}

extension Character {
    static func mockCharacter() ->  Character {
        Character(id: 36,
                  name: "Beta-Seven",
                  status: .alive,
                  species: "Alien",
                  image: "https://rickandmortyapi.com/api/character/avatar/36.jpeg",
                  location: "Earth",
                  numberFirstEpisode: "15",
                  isFavorite: false)
    }
}
