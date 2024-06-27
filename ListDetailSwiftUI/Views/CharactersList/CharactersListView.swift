//
//  CharactersListView.swift
//  ListDetailSwiftUI
//
//  Created by Villanueva, Reinaldo on 24/6/24.
//

import SwiftUI

struct CharactersListView: View {
    
    @State private var searchText = ""
    @ObservedObject private var viewModel: CharactersListViewModel
    @State var delayedSearchTask: Task<(), any Error>?
    
    init(viewModel: CharactersListViewModel = CharactersListViewModel()) {
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
                            self.viewModel.loadMoreContentIfNeeded(currentViewCharacter: character)
                        }
                }
            }
        }
        .onAppear {
            self.viewModel.loadOnFirstAppear()
        }
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        .onSubmit(of: .search, submitSearch)
        .onChange(of: searchText, runDelayedSearch)
        
    }
    
    private func runDelayedSearch() {
        delayedSearchTask?.cancel()
        delayedSearchTask = Task {
            do {
                try await Task.sleep(nanoseconds: 3 * 1_000_000_000)
                runSearch()
            } catch is CancellationError {
                print("Task was cancelled")
            } catch {
                print("ooops! \(error)")
            }
        }
    }
    
    private func submitSearch() {
        delayedSearchTask?.cancel()
        runSearch()
    }
    
    private func runSearch() {
        print("Buscando...")
    }
}

#Preview {
    CharactersListView()
}
