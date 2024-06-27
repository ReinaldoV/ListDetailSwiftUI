//
//  CharactersListView.swift
//  ListDetailSwiftUI
//
//  Created by Villanueva, Reinaldo on 24/6/24.
//

import SwiftUI

struct CharactersListView: View {
    
    @State private var searchText = ""
    @State private var searchTypeSelected: SearchType = .name
    @ObservedObject private var viewModel: CharactersListViewModel
    @State var delayedSearchTask: Task<(), any Error>?
    
    init(viewModel: CharactersListViewModel = CharactersListViewModel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Search by...")
                    .font(.system(size: 10, weight: .thin))
                    .padding(.leading, 15)
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(SearchType.allCases) { type in
                            Text(type.rawValue)
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundStyle(type == searchTypeSelected ? .white : .black)
                                .padding(.horizontal, 15)
                                .padding(.vertical, 10)
                                .background(
                                    type == searchTypeSelected ? Color.brown : Color(UIColor.systemGray6)
                                )
                                .clipShape(.capsule)
                                .onTapGesture {
                                    searchTypeSelected = type
                                }
                        }
                    }
                    .padding(.horizontal, 15)
                }
                List(viewModel.characters) { character in
                    NavigationLink {
                        CharacterDetailView(character: character)
                    } label: {
                        CharacterCellView(character: character)
                            .onAppear {
                                self.viewModel.loadMoreContentIfNeeded(currentViewCharacter: character, withSearch: Search(query: searchText,
                                                                                                                           type: searchTypeSelected))
                            }
                    }
                }
            }
        }
        .onAppear {
            self.viewModel.loadNewCharacters(withSearch: Search(query: searchText,
                                                                type: searchTypeSelected))
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
                try await Task.sleep(nanoseconds: 700_000_000)
                runSearch()
            } catch is CancellationError {
                // Task cancelled
            } catch {
                // Unexpected error
            }
        }
    }
    
    private func submitSearch() {
        delayedSearchTask?.cancel()
        runSearch()
    }
    
    private func runSearch() {
        self.viewModel.loadNewCharacters(withSearch: Search(query: searchText,
                                                            type: searchTypeSelected))
    }
}

#Preview {
    CharactersListView()
}
