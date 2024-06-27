//
//  CharactersListViewModel.swift
//  ListDetailSwiftUI
//
//  Created by Villanueva, Reinaldo on 24/6/24.
//

import Combine
import Foundation

enum SearchType: String, Identifiable, CaseIterable {
    case name = "Name"
    case status = "Status"
    
    var id: Self { self }
}

final class CharactersListViewModel: ObservableObject {
    
    @Published var characters: [Character] = []
    @Published var isLoading: Bool = false
    
    private let charactersUseCase: CharactersUseCaseType
    
    private var cancellables: [AnyCancellable] = []
    
    init(charactersUseCase: CharactersUseCaseType = CharactersUseCase()) {
        self.charactersUseCase = charactersUseCase
    }
    
    func loadOnFirstAppear() {
        askForMoreContent()
    }
    
    func loadMoreContentIfNeeded(currentViewCharacter: Character?) {
        guard let character = currentViewCharacter else {
            // First Load
            askForMoreContent()
            return
        }
        
        let thresholdIndex = characters.index(characters.endIndex, offsetBy: -10)
        if characters.firstIndex(where: { $0.id == character.id }) == thresholdIndex {
            askForMoreContent()
        }
    }
    
    private func askForMoreContent() {
        guard !isLoading else { return }
        
        self.isLoading = true
        
        let cancellable = charactersUseCase
            .callForCharacters()
            .handleEvents(receiveOutput: { _ in
                self.isLoading = false
            })
            .sink { _ in
                // Error handling
            } receiveValue: { self.characters.append(contentsOf: $0) }
        
        cancellables.append(cancellable)
    }
}
