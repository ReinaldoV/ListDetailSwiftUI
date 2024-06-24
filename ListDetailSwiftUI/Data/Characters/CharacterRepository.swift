//
//  CharacterRepository.swift
//  ListDetailSwiftUI
//
//  Created by Villanueva, Reinaldo on 24/6/24.
//

protocol CharacterRepositoryType {}

final class CharacterRepository: CharacterRepositoryType {
    
    init() {
        let request = CharacterListRequest(path: "character")
        let service = APIService(baseURL: "https://rickandmortyapi.com/api/")
        
        service.call(from: request)
    }
}
