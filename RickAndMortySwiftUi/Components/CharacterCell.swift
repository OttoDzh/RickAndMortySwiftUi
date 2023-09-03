//
//  CharacterCell.swift
//  RickAndMortySwiftUi
//
//  Created by Otto Dzhandzhuliya on 27.08.2023.
//

import SwiftUI

struct CharacterCell: View {
    let character: Result
    var body: some View {
        VStack(alignment: .center) {            
            AsyncImage(url: URL(string: character.image)) { image in
                image.resizable()
                    .clipped()
                    .clipShape(.rect(cornerRadius: 15))
            } placeholder: {
                ProgressView()
            } .frame(width:150,height: 190)
            Text(character.name)
                .font(.title3)
                .foregroundStyle(.white)
        } .frame(width: 170,height: 200)
            .padding(.top,16)
            .padding(.leading,8)
            .padding(.trailing,8)
            .padding(.bottom,20)
        .background(Color.cellBg)
        .clipShape(.rect(cornerRadius: 15))
    }
}

