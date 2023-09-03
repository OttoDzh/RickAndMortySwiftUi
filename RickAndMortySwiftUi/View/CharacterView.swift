//
//  ContentView.swift
//  RickAndMortySwiftUi
//
//  Created by Otto Dzhandzhuliya on 27.08.2023.
//

import SwiftUI

let screen = UIScreen.main.bounds

struct CharacterView: View {
    
    let layout = [GridItem(.adaptive(minimum: screen.width / 2.1))]
    @ObservedObject var viewModel = CharacterViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.bg.ignoresSafeArea()
                ScrollView {
                    HStack {
                        Text("Characters")
                            .foregroundStyle(.white)
                            .font(.title)
                        Spacer()
                    }.padding()
                    LazyVGrid(columns: layout) {
                        ForEach(viewModel.characters,id: \.id) { characters in
                            NavigationLink {
                                CharacterDeatilView(character: characters)
                            } label: {
                                CharacterCell(character: characters)
                                    .task {
                                        if viewModel.hasReachEnd(of: characters) {
                                            await self.viewModel.getNextCharacters()
                                    }
                                }
                            }
                        }
                    }.task({
                        await self.viewModel.getCharacterss()
                    })
                }.background(Color.bg.frame(height: 99999999)).padding(.top)
            }
        }
    }
}

struct CharacterView_Test : PreviewProvider {
    static var previews: some View {
        CharacterView()
    }
}
