//
//  PokemonView.swift
//  Pokekodex
//
//  Created by Geszti Bence on 2021. 04. 18..
//

import SwiftUI

struct PokemonView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // MARK:- variables
    let appWidth = UIScreen.main.bounds.width
    let appHeight = UIScreen.main.bounds.height
    let animationDuration: TimeInterval = 0.2
    
    @State var xScale: CGFloat = 0
    @State var yScale: CGFloat = 0
    
    var name: String
    @StateObject var pokemonViewModel = PokemonViewModel()
    
    var body: some View {
        ZStack {
            if !pokemonViewModel.detailedPokemon.isEmpty {
                Circle()
                    .fill(pokemonViewModel.detailedPokemon[0].backgroundColor)
                    .scaleEffect(CGSize(width: xScale, height: yScale))
                    .offset(y: 0)
                    .onAppear {
                        let baseAnimation = Animation.easeInOut(duration: 0.5)
                        withAnimation(baseAnimation) {
                            xScale = 10.0
                            yScale = 10.0
                        }
                    }
                VStack(alignment: .leading) {
                    btnBack
                        .padding([.top], 24)
                        .padding([.bottom], 30)
                        .opacity(0)
                    Text(verbatim: pokemonViewModel.detailedPokemon[0].name)
                        .font(.largeTitle).bold()
                        .foregroundColor(.white)
                        .padding([.leading], 16)
                    if let first = pokemonViewModel.detailedPokemon[0].types.first ?? "" {
                        Text("\(first) type Pokemon")
                            .font(.subheadline).italic()
                            .foregroundColor(.white)
                            .opacity(0.8)
                            .padding([.leading], 16)
                    }
                    
                    HStack(alignment: .center) {
                        Spacer()
                        AsyncImage(
                            url: URL(string: pokemonViewModel.detailedPokemon[0].image)!,
                            placeholder: { ProgressView() },
                            image: { Image(uiImage: $0).resizable() }
                        )
                        .frame(width: 300, height: 300, alignment: .center)
                        Spacer()
                    }

                    HStack {
                        Spacer()
                        VStack(alignment: .center) {
                            Text("#\(pokemonViewModel.detailedPokemon[0].number)")
                                .font(.largeTitle)
                                .foregroundColor(.white)

                            Text(verbatim: pokemonViewModel.detailedPokemon[0].name)
                                .font(.largeTitle).bold()
                                .foregroundColor(.white)
                                .padding([.leading], 16)
                        }
                        Spacer()
                    }
                    
                    Spacer()
                }
            }
            
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarItems(leading: btnBack)
        .navigationBarBackButtonHidden(true)
        .onAppear(perform: {
            loadData()
        })
        
    }
    
    func loadData() {
        pokemonViewModel.fetchPokemon(endpoint: .pokemon(name))
    }
    
    var btnBack : some View { Button(action: {
                self.presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "arrow.left")
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.white)
                            .font(.system(size: 24, weight: .semibold, design: .monospaced))
                        Spacer()
                    }
        
                }
        }
}

struct PokemonView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PokemonView(name: "Bulbasaur")
        }
    }
}
