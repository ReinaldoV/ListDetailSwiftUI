//
//  CharacterRepository.swift
//  ListDetailSwiftUI
//
//  Created by Villanueva, Reinaldo on 24/6/24.
//

import Combine
import Foundation

protocol CharacterRepositoryType {
    func callForCharacters(pageNum: Int) -> AnyPublisher<(ResponseInfoEntity, [CharacterEntity]), Error>
}

final class CharacterRepository: CharacterRepositoryType {
    
    init() {}
    
    func callForCharacters(pageNum: Int) -> AnyPublisher<(ResponseInfoEntity, [CharacterEntity]), Error> {
        let request = CharacterListRequest(path: "character",
                                           queryItems: [URLQueryItem(name: "page",
                                                                     value: pageNum.description)])
        let service = APIService(baseURL: "https://rickandmortyapi.com/api/")
        
        return service.call(from: request)
            .map { ($0.info.toResponseInfoEntity(), $0.results.map { $0.toCharacterEntity() }) }
            .eraseToAnyPublisher()
    }
}
