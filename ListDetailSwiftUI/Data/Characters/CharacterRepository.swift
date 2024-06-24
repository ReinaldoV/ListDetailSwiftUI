//
//  CharacterRepository.swift
//  ListDetailSwiftUI
//
//  Created by Villanueva, Reinaldo on 24/6/24.
//

import Combine

protocol CharacterRepositoryType {
    func callForCharacters() -> AnyPublisher<(ResponseInfo, [Character]), Error>
}

final class CharacterRepository: CharacterRepositoryType {
    
    init() {}
    
    func callForCharacters() -> AnyPublisher<(ResponseInfo, [Character]), Error> {
        let request = CharacterListRequest(path: "character")
        let service = APIService(baseURL: "https://rickandmortyapi.com/api/")
        
        return service.call(from: request)
            .map { ($0.info.toResponseInfo(), $0.results.map { $0.toCharacter() }) }
            .eraseToAnyPublisher()
    }
}
