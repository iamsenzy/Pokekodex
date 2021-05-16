//
//  PokemonListView.swift
//  Pokekodex
//
//  Created by Geszti Bence on 2021. 05. 16..
//

import SwiftUI
import Combine

struct PokemonListView: View {
    @StateObject var pokemonListVM = PokemonListViewModel()
    
    @State private var limit: Int = 10
    
    var body: some View {
        ZStack {
            if pokemonListVM.pokemons.isEmpty {
                ProgressView()
            } else {
                List {
                    ForEach(pokemonListVM.pokemons, id:\.id) { pokemon in
                        NavigationLink(
                            destination: PokemonView(name: pokemon.name)) {
                            HStack {
                                Image("pokeBall")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.red)
                                VStack (alignment: .leading) {
                                    Text(pokemon.name)
                                        .font(.headline)
                                }
                            }
                        }
                        
                    }
                    Button("Load more") {
                        limit += 10
                        pokemonListVM.fetchUsers(endpoint: .pokemonList(limit))
                    }
                }
                .listStyle(InsetGroupedListStyle())
            }
        }
        .navigationTitle("Pokemons")
        .onAppear{
            pokemonListVM.fetchUsers(endpoint: .pokemonList(limit))
        }
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
