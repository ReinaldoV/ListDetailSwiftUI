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
    
    init(characterRepository: CharacterRepositoryType = CharacterRepository()) {
        self.characterRepository = characterRepository
    }
    
    func callForCharacters() -> AnyPublisher<[Character], Error> {
        characterRepository
            .callForCharacters()
            .map { $0.1.map { $0.toCharacter() }}
            .eraseToAnyPublisher()
    }
}
