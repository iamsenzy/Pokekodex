//
//  URLEndPointa.swift
//  Pokekodex
//
//  Created by Geszti Bence on 2021. 05. 16..
//

import Foundation

enum URLEndPoint {
    case pokemon(String)
    case pokemonList(Int)
    
    var baseUrl: String {
      return ""
    }
    
    var urlString: String {
        switch self {
        case .pokemon(let name):
            return "https://pokeapi.glitch.me/v1/pokemon/\(name)"
        case .pokemonList(let limit):
            return "https://pokeapi.co/api/v2/pokemon?offset=0&limit=\(limit)"
        }
    }
}
