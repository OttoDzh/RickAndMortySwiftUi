//
//  CharacterDeatilView.swift
//  RickAndMortySwiftUi
//
//  Created by Otto Dzhandzhuliya on 28.08.2023.
//

import SwiftUI

struct CharacterDeatilView: View {
    @ObservedObject var viewModel = CharacterViewModel()
    @State private var showPupUp : Bool = false
    var character: Result
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .center) {
                    AsyncImage(url: URL(string: character.image)) { image in
                        image.resizable()
                            .clipped()
                            .onTapGesture {
                                self.showPupUp = true
                            }
                    } placeholder: {
                        ProgressView()
                    } .frame(width:150,height: 150)
                        .background(Color.clear)
                        .clipShape(.rect(cornerRadius: 15))
                    Text(character.name)
                        .padding(.vertical,6)
                        .foregroundStyle(.white)
                    
                    if character.status == Status.Alive.rawValue {
                        Text(character.status)
                            .foregroundStyle(.green)
                    } else if character.status == Status.Dead.rawValue {
                        Text(character.status)
                            .foregroundStyle(.red)
                    } else {
                        Text(character.status)
                            .foregroundStyle(.white)
                    }
                    if $showPupUp.wrappedValue {
                        if character.status == "Alive" {
                            makePopUpView(url: character.image,color: .green)
                                .onTapGesture {
                                    self.showPupUp = false
                                }

                        } else if character.status == "Dead"{
                            makePopUpView(url: character.image,color: .red)
                                .onTapGesture {
                                    self.showPupUp = false
                                }
                        } else {
                            makePopUpView(url: character.image,color: .white)
                                .onTapGesture {
                                    self.showPupUp = false
                            }
                        }
                    }
                    HStack {
                        Text("Info")
                            .font(.title)
                            .foregroundStyle(.white)
                        Spacer()
                    }.padding()
                    VStack {
                        HStack {
                          makeText(text: "Species:")
                            Spacer()
                            Text(character.species)
                                .foregroundStyle(.white)
                        }.padding(6)
                        HStack {
                            makeText(text: "Types:")
                            Spacer()
                            Text(character.type)
                                .foregroundStyle(.white)
                        }.padding(6)
                        HStack {
                            makeText(text: "Male:")
                            Spacer()
                            Text(character.gender)
                                .foregroundStyle(.white)
                        }.padding(6)
                        
                    }.padding()
                        .background(Color.cellBg)
                        .clipShape(.rect(cornerRadius: 12))
                        .padding(6)
                    
                    HStack {
                        Text("Origin")
                            .font(.title)
                            .foregroundStyle(.white)
                        Spacer()
                    }.padding()
                    
                    HStack {
                        HStack {
                            Image("planetImage")
                                .resizable()
                                .frame(width:30,height: 30)
                                .padding(20)
                                .background(Color.bg)
                                .clipShape(.rect(cornerRadius: 12))
                            VStack(alignment:.leading) {
                                Text(character.location.name)
                                    .font(.title)
                                    .foregroundStyle(.white)
                                    .lineLimit(1)
                                Text("Planet")
                                    .foregroundStyle(.green)
                            }.padding()
                        }.padding(.horizontal)
                        Spacer()
                        HStack {
                        }
                    }.frame(maxWidth:.infinity,maxHeight:150)
                        .background(Color.cellBg)
                        .clipShape(.rect(cornerRadius: 12))
                        .padding(6)
                        .padding(.bottom,24)
                    ScrollView(.vertical) {
                        ForEach(viewModel.episodes,id: \.id) { episode in
                            EpisodeCell(episode: episode)
                                .listRowBackground(Color.bg)
                        }.task {
                            await self.viewModel.getCharacterss()
                            await self.viewModel.getEpisode(fetchUrl: character.episode)
                        }.refreshable {
                            await self.viewModel.getCharacterss()
                            await self.viewModel.getEpisode(fetchUrl: character.episode)
                        }
                    }.frame(maxWidth: .infinity,maxHeight: .infinity)
                        .background(Color.bg)
                }
            }
        } .background(Color.bg.frame(height: 99999999)).padding(.top)
        
    }
}
@ViewBuilder func makePopUpView(url:String,color:Color) -> some View {
    ZStack {
        Color.white
        VStack {
            AsyncImage(url: URL(string: url)) { image in
                image.resizable()
                    .clipped()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }.frame(width:400,height: 400)
        }.padding()
    }
    .frame(width: 350, height: 400)
    .cornerRadius(20).shadow(radius: 20)
    .shadow(color: color, radius: 20)
}

@ViewBuilder func makeText(text:String) -> some View {
    Text(text)
        .font(.title2)
        .foregroundStyle(.white)
}

struct TestView_Previews : PreviewProvider {
    static var previews: some View {
        CharacterView()
    }
}

extension Episode: Identifiable {
    public var id : UUID {
        get {
            return UUID()
        }
    }
}

enum Status:String {
    case Alive = "Alive"
    case Dead = "Dead"
    case unknown = "unknow"
}
