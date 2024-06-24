//
//  CharacterCellView.swift
//  ListDetailSwiftUI
//
//  Created by Villanueva, Reinaldo on 24/6/24.
//

import SwiftUI

struct CharacterCellView: View {
    
    let character: Character
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(character.name)
                .font(.system(size: 25, weight: .bold))
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            HStack(spacing: 10) {
                AsyncImage(url: URL(string: character.image)){ result in
                    result.image?
                        .resizable()
                        .scaledToFill()
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
    CharacterCellView(character: Character(id: 36,
                                           name: "Beta-Seven",
                                           status: .alive,
                                           species: "Alien",
                                           image: "https://rickandmortyapi.com/api/character/avatar/36.jpeg",
                                           location: "Earth",
                                           numberFirstEpisode: "15",
                                           isFavorite: false))
}