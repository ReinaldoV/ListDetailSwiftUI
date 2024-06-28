//
//  CharacterCellView.swift
//  ListDetailSwiftUI
//
//  Created by Villanueva, Reinaldo on 24/6/24.
//

import SwiftUI

struct CharacterCellView: View {
    
    @ObservedObject private var viewModel: FavoritesViewModel
    @State private var isFavorite: Bool
    let character: Character
    
    init(character: Character,
         viewModel: FavoritesViewModel = FavoritesViewModel()) {
        self.character = character
        self.viewModel = viewModel
        
        isFavorite = viewModel.isFavorite(character: character)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack(spacing: 0, content: {
                Text(character.name)
                    .font(.system(size: 25, weight: .bold))
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                
                Spacer()
                
                Image(systemName: isFavorite ? "heart.fill": "heart")
                    .foregroundStyle(isFavorite ? .green : .brown)
                    .font(.title2)
                    .symbolEffect(.bounce, options: .speed(2), value: isFavorite)
                    .padding(.trailing, -20)
                    .onTapGesture {
                        isFavorite = viewModel.updateFavorite(character: character)
                    }
                    .onAppear {
                        isFavorite = viewModel.isFavorite(character: character)
                    }
            })
            HStack(spacing: 10) {
                AsyncImage(url: URL(string: character.image)){ phase in
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
                .frame(width: 150, height: 150)
                VStack(alignment: .leading, spacing: 0) {
                    statusRow(status: character.status, species: character.species)
                        .padding(.top, 20)
                    Spacer()
                    extraInfo(title: "Last known location:",
                              info: character.location)
                    Spacer()
                    extraInfo(title: "First seen in:",
                              info: "Episode \(character.numberFirstEpisode)")
                    Spacer()
                }
            }
        }
    }
    
    private func statusRow(status: Status, species: String) -> some View {
        HStack {
            Circle()
                .fill(status == .alive ? .green : status == .dead ? .red : .gray)
                .frame(width: 15)
            Text("\(status.rawValue) - \(species)").lineLimit(1)
                .font(.system(size: 15, weight: .medium))
        }
    }
    
    private func extraInfo(title: String, info: String) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title).lineLimit(1)
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(.gray.gradient)
            Text(info).lineLimit(3)
                .font(.system(size: 12, weight: .semibold))
        }
    }
}

#Preview {
    CharacterCellView(character: Character.mockCharacter())
}
