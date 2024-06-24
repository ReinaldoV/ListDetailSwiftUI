//
//  Character.swift
//  ListDetailSwiftUI
//
//  Created by Villanueva, Reinaldo on 24/6/24.
//

struct Character {
    var id: Int
    var name: String
    var status: Status
    var species: String
    var image: String
}

enum Status {
    case alive
    case dead
    case unknown
}
