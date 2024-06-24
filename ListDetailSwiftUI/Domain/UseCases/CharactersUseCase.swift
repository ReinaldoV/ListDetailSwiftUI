//
//  CharactersUseCase.swift
//  ListDetailSwiftUI
//
//  Created by Villanueva, Reinaldo on 24/6/24.
//

import Combine

protocol CharactersUseCaseType {
    func callForCharacters() -> AnyPublisher<[Character], Error>
}

final class CharactersUseCase: CharactersUseCaseType {
    
    let characterRepository: CharacterRepositoryType
    var currentPage = 0
    var canLoadMorePages: Bool = true
    
    init(characterRepository: CharacterRepositoryType = CharacterRepository()) {
        self.characterRepository = characterRepository
    }
    
    func callForCharacters() -> AnyPublisher<[Character], Error> {
        currentPage += 1
        return characterRepository
                .callForCharacters(pageNum: currentPage)
                .map({ (info, characters) in
                    self.canLoadMorePages = info.next != nil
                    return characters.map { $0.toCharacter() }
                })
                .eraseToAnyPublisher()
    }
}
