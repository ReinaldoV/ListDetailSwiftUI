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
    var isFavorite: Bool = false
}

enum Status {
    case alive
    case dead
    case unknown
}
