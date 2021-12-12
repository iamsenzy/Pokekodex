//
//  PokemonListViewModel.swift
//  Pokekodex
//
//  Created by Geszti Bence on 2021. 05. 16..
//

import Foundation
import Combine

class PokemonListViewModel: ObservableObject {
    @Published var pokemons = [ListViePokemonwModel]()
    private let apiManager: APIManager = APIManager()
    
    func fetchPokemons(endpoint: URLEndPoint) {
        let url = URL(string: endpoint.urlString)!
        
        apiManager.fetch(url: url) { (result: Result<PokemonResults, Error>) in
            switch result {
            case .success(let result):
                self.pokemons = result.pokemons.map{ ListViePokemonwModel($0) }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

struct ListViePokemonwModel: Identifiable {
    let id = UUID()
    private let pokemon: Pokemon
    
    var name: String {
        return pokemon.name
    }
    
    var url: String {
        return pokemon.url
    }
    
    init(_ pokemon: Pokemon) {
        self.pokemon = pokemon
    }
}


