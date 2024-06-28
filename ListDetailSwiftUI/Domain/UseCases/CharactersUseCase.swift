//
//  CharactersUseCase.swift
//  ListDetailSwiftUI
//
//  Created by Villanueva, Reinaldo on 24/6/24.
//

import Combine

protocol CharactersUseCaseType: AutoMockable {
    func callForCharacters(withSearch search: Search) -> AnyPublisher<[Character], Error>
}

final class CharactersUseCase: CharactersUseCaseType {
    
    let characterRepository: CharacterRepositoryType
    var currentPage = 0
    var canLoadMorePages: Bool = true
    var lastSearch: SearchEntity?
    
    init(characterRepository: CharacterRepositoryType = CharacterRepository()) {
        self.characterRepository = characterRepository
    }
    
    func callForCharacters(withSearch search: Search) -> AnyPublisher<[Character], Error> {
        currentPage += 1
        let newSearch = SearchEntity.init(withSearch: search)
        if newSearch != lastSearch {
            currentPage = 1
            lastSearch = newSearch
        }
        return characterRepository
                .callForCharacters(pageNum: currentPage, withSearch: newSearch)
                .map({ (info, characters) in
                    self.canLoadMorePages = info.next != nil
                    return characters.map { $0.toCharacter() }
                })
                .eraseToAnyPublisher()
    }
}
