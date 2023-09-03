//
//  EpisodeCell.swift
//  RickAndMortySwiftUi
//
//  Created by Otto Dzhandzhuliya on 29.08.2023.
//

import SwiftUI

struct EpisodeCell: View {
    
    var episode: Episode
    
    var body: some View {
        VStack {
            HStack {
                makeText(text: episode.name)
                Spacer()
            }.padding(12)
            HStack {
                Text(episode.episode.replacingOccurrences(of: "E", with: " Episode: ").replacingOccurrences(of: "S", with: "Season: "))
                    .font(.headline)
                    .foregroundStyle(.green)
                Spacer()
                Text(episode.air_date)
                    .foregroundStyle(.gray)
                   
            }.padding(.horizontal,12)
                .padding(.bottom,6)
        }.frame(maxWidth: .infinity,maxHeight: 100)
            .background(Color.cellBg)
         .background(Color.gray)
         .clipShape(.rect(cornerRadius: 12))
         .padding(.horizontal,6)
    }
}

#Preview {
    EpisodeCell(episode: Episode(name: "Get a nap", characters: [""], episode: "S1 E1", air_date: "No date"))
}
