//
//  CharacterDetail.swift
//  ListDetailSwiftUI
//
//  Created by Villanueva, Reinaldo on 25/6/24.
//

import SwiftUI

struct CharacterDetail: View {
    let character: Character
    
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
            
            VStack(alignment: .leading, spacing: 30, content: {
                statusRow(status: character.status, species: character.species)
                    .padding(.top, 20)
                extraInfo(title: "Last known location:",
                          info: character.location)
                extraInfo(title: "First seen in:",
                          info: "Episode \(character.numberFirstEpisode)")
                Spacer()
            })
            .padding(.horizontal, 20)
            
            Spacer()
        }.navigationTitle(character.name)
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
}

#Preview {
    CharacterDetail(character: Character.mockCharacter())
}
