//
//  ContentView.swift
//  Pokekodex
//
//  Created by Geszti Bence on 2021. 05. 16..
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            PokemonListView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
