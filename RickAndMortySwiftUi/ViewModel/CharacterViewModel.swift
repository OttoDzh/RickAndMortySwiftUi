//
//  CharacterViewModel.swift
//  RickAndMortySwiftUi
//
//  Created by Otto Dzhandzhuliya on 28.08.2023.
//

import Foundation
import SwiftUI

class CharacterViewModel : ObservableObject {
    
    @Published var characters: [Result] = []
    @Published var episodes: [Episode] = []
    
     var page = 1
     func getEpisode(fetchUrl:[String]) async {
         for item in fetchUrl {
             let url = URL(string: item)
             let urlSession = URLSession.shared
             do {
                 let (data, _) = try await urlSession.data(from: url!)
                 let episode = try JSONDecoder().decode(Episode.self, from: data)
                  DispatchQueue.main.async {
                     self.episodes.append(episode)
                 }
             }
             catch {
                 debugPrint("Error loading \(String(describing: url)): \(String(describing: error))")
             }
         }
    
    }
     func getCharacterss() async  {
         if self.page == 1 {
             let url = URL(string: "https://rickandmortyapi.com/api/character/?page=\(self.page)")!
             let urlSession = URLSession.shared
             do {
                 let (data, _) = try await urlSession.data(from: url)
                 let characters = try JSONDecoder().decode(Character.self, from: data)
                  DispatchQueue.main.async {
                     self.characters = characters.results
                 }
             }
             catch {
                 debugPrint("Error loading \(url): \(String(describing: error))")
             } } else {
                 print("hmm")
             }
    }
    func getNextCharacters() async {
          page += 1
        let url = URL(string: "https://rickandmortyapi.com/api/character/?page=\(self.page)")!
        let urlSession = URLSession.shared
        do {
            let (data, _) = try await urlSession.data(from: url)
            let characters = try JSONDecoder().decode(Character.self, from: data)
              DispatchQueue.main.async {
                self.characters  += characters.results
            }
        }
        catch {
            debugPrint("Error loading \(url): \(String(describing: error))")
        }
    }
    func hasReachEnd(of characters: Result) -> Bool {
        self.characters.last?.id == characters.id
    }

}
