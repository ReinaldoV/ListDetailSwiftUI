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
    var count: Int
    var pages: Int
    var next: String?
    var prev: String?
    var results: [CharacterDTO]
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
}
