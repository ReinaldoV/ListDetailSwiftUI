//
//  CharactersListView.swift
//  ListDetailSwiftUI
//
//  Created by Villanueva, Reinaldo on 24/6/24.
//

import SwiftUI

struct CharactersListView: View {
    
    @ObservedObject private var viewModel: CharactersListViewModel
    
    init(viewModel: CharactersListViewModel = CharactersListViewModel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            List(viewModel.characters) { character in
                
                NavigationLink {
                    CharacterDetail(character: character)
                } label: {
                    CharacterCellView(character: character)
                        .onAppear {
                            self.viewModel.loadMoreContentIfNeeded(currentViewCharacter: character)
                        }
                }
            }
        }
        .onAppear {
            self.viewModel.loadOnFirstAppear()
        }
    }
}

#Preview {
    CharactersListView()
}
