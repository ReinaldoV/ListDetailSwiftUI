//
//  CharacterDetailView.swift
//  ListDetailSwiftUI
//
//  Created by Villanueva, Reinaldo on 25/6/24.
//

import SwiftUI

struct CharacterDetailView: View {
    
    @ObservedObject private var viewModel: CharacterDetailViewModel
    
    let character: Character
    
    init(character: Character,
         viewModel: CharacterDetailViewModel? = nil) {
        self.character = character
        self.viewModel = viewModel ?? CharacterDetailViewModel(character: character)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            AsyncImage(url: URL(string: character.image)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
            }
            .frame(height: 300)
            .clipped()
            
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
                            .frame(width: 200)
                            .border(.gray)
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
            })
            
            HStack(alignment: .top, spacing: 0, content: {
                Text("Episode: ")
                    .font(.system(size: 18, weight: .semibold))
                Text(episode.episode)
                    .lineLimit(5)
                    .font(.system(size: 18, weight: .regular))
            })
        }
    }
}

#Preview {
    CharacterDetailView(character: Character.mockCharacter())
}
