//
//  PokemonModel.swift
//  Pokekodex
//
//  Created by Geszti Bence on 2021. 05. 16..
//

import Foundation

struct PokemonResults: Decodable {
    var pokemons: [Pokemon]
    enum CodingKeys: String, CodingKey {
        case pokemons = "results"
    }
}

struct Pokemon: Decodable {
    var url: String
    var name: String
}

struct DetailedPokemon: Decodable {
    var number: String
    var name: String
    var types: [String]
    var sprite: String
    var description: String
}

