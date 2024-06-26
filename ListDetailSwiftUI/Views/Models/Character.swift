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
    var origin: String
    var location: String
    var episodes: [Int]
    
    var numberFirstEpisode: String {
        self.episodes.first?.description ?? "N/A"
    }
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
                  origin: "Earth",
                  location: "Earth",
                  episodes: [15])
    }
}
