//
//  PokemonViewModel.swift
//  Pokekodex
//
//  Created by Geszti Bence on 2021. 05. 16..
//

import SwiftUI
import Combine

class PokemonViewModel: ObservableObject {
    @Published var detailedPokemon = [DetailedPokemonModel]()
    private let apiManager: APIManager = APIManager()
    
    func fetchPokemon(endpoint: URLEndPoint) {
        let url = URL(string: endpoint.urlString)!
        
        apiManager.fetch(url: url) { (result: Result<[DetailedPokemon], Error>) in
            switch result {
            case .success(let result):
                self.detailedPokemon = result.map{ DetailedPokemonModel($0) }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

struct DetailedPokemonModel: Identifiable {
    let id = UUID()
    private let pokemon: DetailedPokemon
    
    var name: String {
        return pokemon.name
    }
    
    var number: Int {
        return Int(pokemon.number) ?? 1
    }
    
    var types: [String] {
        return pokemon.types
    }
    
    var image: String {
        return pokemon.sprite
    }
    
    var description: String {
        return pokemon.description
    }
    
    var backgroundColor: Color {
        return getColor(type: pokemon.types.first ?? "")
    }
    
    init(_ pokemon: DetailedPokemon) {
        self.pokemon = pokemon
    }
    
    private func getColor(type: String) -> Color {
        var color: Color = .white
        let type: PokemonType = PokemonType(rawValue: type) ?? .Fire
        switch type {
        case .Bug, .Grass, .Dragon :
            color = .green
        case .Electric:
           color = .yellow
        case .Fire:
            color = .red
        case .Poison, .Psychic, .Dark, .Ghost:
            color = .purple
        case .Rock, .Steel:
            color = .gray
        case .Water, .Flying, .Ice:
           color = .blue
        default:
            color = .orange
        }
        return color
    }
}

