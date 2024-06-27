//
//  CharactersListViewModel.swift
//  ListDetailSwiftUI
//
//  Created by Villanueva, Reinaldo on 24/6/24.
//

import Combine
import Foundation

final class CharactersListViewModel: ObservableObject {
    
    @Published var characters: [Character] = []
    @Published var isLoading: Bool = false
    
    private let charactersUseCase: CharactersUseCaseType
    
    private var cancellables: [AnyCancellable] = []
    
    init(charactersUseCase: CharactersUseCaseType = CharactersUseCase()) {
        self.charactersUseCase = charactersUseCase
    }
    
    func loadNewCharacters(withSearch search: Search) {
        characters = []
        askForMoreContent(withSearch: search)
    }
    
    func loadMoreContentIfNeeded(currentViewCharacter: Character?, withSearch search: Search) {
        guard let character = currentViewCharacter else {
            // First Load
            askForMoreContent(withSearch: search)
            return
        }
        
        let thresholdIndex = characters.index(characters.endIndex, offsetBy: -10)
        if characters.firstIndex(where: { $0.id == character.id }) == thresholdIndex {
            askForMoreContent(withSearch: search)
        }
    }
    
    private func askForMoreContent(withSearch search: Search) {
        guard !isLoading else { return }
        
        self.isLoading = true
        
        let cancellable = charactersUseCase
            .callForCharacters(withSearch: search)
            .handleEvents(receiveOutput: { _ in
                self.isLoading = false
            })
            .sink { _ in
                // Error handling
            } receiveValue: { self.characters.append(contentsOf: $0) }
        
        cancellables.append(cancellable)
    }
}
