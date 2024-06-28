//
//  CharacterDetailView.swift
//  ListDetailSwiftUI
//
//  Created by Villanueva, Reinaldo on 25/6/24.
//

import SwiftUI

struct CharacterDetailView: View {
    
    @ObservedObject private var viewModel: CharacterDetailViewModel
    @State private var isFavorite: Bool
    
    let character: Character
    
    init(character: Character,
         viewModel: CharacterDetailViewModel? = nil) {
        self.character = character
        let viewModel = viewModel ?? CharacterDetailViewModel(character: character)
        self.viewModel = viewModel
        
        isFavorite = viewModel.isFavorite(character: character)
    }
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 20) {
                ZStack {
                    AsyncImage(url: URL(string: character.image)) { phase in
                        switch phase {
                        case .empty:
                            VStack(alignment: .center) {
                                Spacer()
                                HStack(alignment: .center) {
                                    Spacer()
                                    ProgressView()
                                    Spacer()
                                }
                                Spacer()
                            }
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        case .failure(_):
                            Image("default")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        @unknown default:
                            Image("default")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        }
                    }
                    .frame(height: 300)
                    .clipped()
                    
                    VStack(alignment: .trailing, spacing: 0) {
                        HStack(alignment: .top, spacing: 0) {
                            Spacer()
                            Image(systemName: isFavorite ? "heart.fill": "heart")
                                .foregroundStyle(isFavorite ? .green : .gray)
                                .font(.largeTitle)
                                .symbolEffect(.bounce, options: .speed(2), value: isFavorite)
                                .padding(5)
                                .padding(.top, 2)
                                .background(Color.white)
                                .clipShape(Circle())
                                .padding(15)
                                .onTapGesture {
                                    isFavorite = viewModel.updateFavorite(character: character)
                                }
                                .onAppear {
                                    isFavorite = viewModel.isFavorite(character: character)
                                }
                        }
                        Spacer()
                    }
                }
                
                VStack(alignment: .center){
                    Text(character.name)
                        .font(.system(size: 30, weight: .bold))
                }.frame(maxWidth: .infinity)
                
                VStack(alignment: .leading, spacing: 20, content: {
                    statusRow(status: character.status, species: character.species)
                        .padding(.top, 20)
                    extraInfo(title: "Last known location:",
                              info: character.location)
                    extraInfo(title: "First seen in:",
                              info: "Episode \(character.numberFirstEpisode)")
                    listOfEpisodes()
                })
                .padding(.horizontal, 20)
                
                Spacer()
            }
            .navigationTitle(character.name)
            .onAppear(perform: {
                viewModel.loadEpisodes()
            })
        }
    }
    
    private func statusRow(status: Status, species: String) -> some View {
        HStack {
            Circle()
                .fill(status == .alive ? .green : status == .dead ? .red : .gray)
                .frame(width: 15)
            Text("\(status.rawValue) - \(species)").lineLimit(1)
                .font(.system(size: 20, weight: .medium))
        }
    }
    
    private func extraInfo(title: String, info: String) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title).lineLimit(1)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(.gray.gradient)
            Text(info).lineLimit(3)
                .font(.system(size: 17, weight: .semibold))
        }
    }
    
    private func listOfEpisodes() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("List of episodes").lineLimit(1)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(.gray.gradient)
            ScrollView(.horizontal) {
                LazyHStack(spacing: 20) {
                    ForEach(viewModel.episodes, id: \.id) { episode in
                        episodeCell(episode: episode)
                            .frame(width: 214, height: 108)
                            .background(Color(UIColor.systemGray6))
                            .clipShape(
                                .rect(
                                    topLeadingRadius: 20,
                                    bottomLeadingRadius: 20,
                                    bottomTrailingRadius: 20,
                                    topTrailingRadius: 20
                                )
                            )
                            .padding(.vertical, 10)
                    }
                    .listStyle(.plain)
                }
            }
        }
    }
    
    private func episodeCell(episode: Episode) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top, spacing: 0, content: {
                Text("Name: ")
                    .font(.system(size: 18, weight: .semibold))
                Text(episode.name)
                    .lineLimit(5)
                    .font(.system(size: 18, weight: .regular))
                Spacer()
            })
            
            HStack(alignment: .top, spacing: 0, content: {
                Text("Episode: ")
                    .font(.system(size: 18, weight: .semibold))
                Text(episode.episode)
                    .lineLimit(5)
                    .font(.system(size: 18, weight: .regular))
                Spacer()
            })
        }
        .padding(.vertical, 4)
        .padding(.horizontal, 7)
    }
}

#Preview {
    CharacterDetailView(character: Character.mockCharacter())
}
