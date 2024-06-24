//
//  CharactersListViewModel.swift
//  ListDetailSwiftUI
//
//  Created by Villanueva, Reinaldo on 24/6/24.
//

import Combine
import Foundation

protocol CharactersListViewModelType {
    var characters: [Character] { get }
    var isLoading: Bool { get }
    func loadOnFirstAppear()
    func checkIfMoreCharactersNeedsToLoad()
}

final class CharactersListViewModel: ObservableObject, CharactersListViewModelType {
    
    @Published var characters: [Character] = []
    @Published var isLoading: Bool = false
    
    private let charactersUseCase: CharactersUseCaseType
    
    private var cancellables: [AnyCancellable] = []
    
    init(charactersUseCase: CharactersUseCaseType = CharactersUseCase()) {
        self.charactersUseCase = charactersUseCase
    }
    
    func loadOnFirstAppear() {
        let cancellable = charactersUseCase
            .callForCharacters()
            .sink { _ in
                // Error handling
            } receiveValue: { self.characters.append(contentsOf: $0) }
        
        cancellables.append(cancellable)
    }
    
    func checkIfMoreCharactersNeedsToLoad() {
        
    }
}
