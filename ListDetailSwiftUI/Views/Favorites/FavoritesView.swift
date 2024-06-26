//
//  FavoritesView.swift
//  ListDetailSwiftUI
//
//  Created by Villanueva, Reinaldo on 26/6/24.
//

import SwiftUI

struct FavoritesView: View {
    
    @ObservedObject private var viewModel: FavoritesViewModel
    
    init(viewModel: FavoritesViewModel = FavoritesViewModel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            List(viewModel.characters) { character in
                
                NavigationLink {
                    CharacterDetailView(character: character)
                } label: {
                    CharacterCellView(character: character)
                        .onAppear {
//                            self.viewModel.loadMoreContentIfNeeded(currentViewCharacter: character)
                        }
                }
            }
        }
        .onAppear {
//            self.viewModel.loadOnFirstAppear()
        }
    }
}

#Preview {
    CharactersListView()
}
