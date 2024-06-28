//
//  CharacterRepository.swift
//  ListDetailSwiftUI
//
//  Created by Villanueva, Reinaldo on 24/6/24.
//

import Combine
import Foundation

protocol CharacterRepositoryType: AutoMockable {
    func callForCharacters(pageNum: Int, withSearch: SearchEntity) -> AnyPublisher<(ResponseInfoEntity, [CharacterEntity]), Error>
}

final class CharacterRepository: CharacterRepositoryType {
    
    init() {}
    
    func callForCharacters(pageNum: Int, withSearch search: SearchEntity) -> AnyPublisher<(ResponseInfoEntity, [CharacterEntity]), Error> {
        var queryItems = [URLQueryItem(name: "page",
                                       value: pageNum.description)]
        if !search.query.isEmpty {
            queryItems.append(URLQueryItem(name: search.type.rawValue,
                                           value: search.query))
        }
        let request = CharacterListRequest(path: "character",
                                           queryItems: queryItems)
        let service = APIService(baseURL: "https://rickandmortyapi.com/api/")
        
        return service.call(from: request)
            .map { ($0.info.toResponseInfoEntity(), $0.results.map { $0.toCharacterEntity() }) }
            .eraseToAnyPublisher()
    }
}
