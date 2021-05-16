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
    
    @Binding var pokemonUrl: String
    @State private var pokemon: [User]
    var backgroundColor: Color
    @State var color: Color = .red
    @State var pokemonImage: String = ""
    
    var body: some View {
        ZStack {
            backgroundColor
            Circle()
                .fill(color)
                .scaleEffect(CGSize(width: xScale, height: yScale))
                .offset(y: 0)
            VStack(alignment: .leading) {
                btnBack
                    .padding([.top], 24)
                    .padding([.bottom], 30)
                    .opacity(0)
                Text(verbatim: pokemon[0].name)
                    .font(.largeTitle).bold()
                    .foregroundColor(.white)
                    .padding([.leading], 16)
                if let first = pokemon[0].types.first ?? "" {
                    Text("\(first) type Pokemon")
                        .font(.subheadline).italic()
                        .foregroundColor(.white)
                        .opacity(0.8)
                        .padding([.leading], 16)
                }
                
                HStack {
                    Spacer()
                    VStack(alignment: .center) {
                        Text("#\(pokemon[0].number)")
                            .font(.largeTitle)
                            .foregroundColor(.white)

                        Text(verbatim: pokemon[0].name)
                            .font(.largeTitle).bold()
                            .foregroundColor(.white)
                            .padding([.leading], 16)
                    }
                    Spacer()
                }
                
                Spacer()
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
        guard let url = URL(string: pokemonUrl) else {
            print("Invalid URL")
            return
        }
        
        print(url)
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode([User].self, from: data) {
                    DispatchQueue.main.async {
                        self.pokemon = decodedResponse
                        let type: PokemonType = PokemonType(rawValue: pokemon[0].types.first ?? "") ?? .Fire
                        switch type {
                        case .Bug, .Grass, .Dragon : self.color = .green
                        case .Electric:
                            self.color = .yellow
                        case .Fire:
                            self.color = .red
                        case .Poison, .Psychic, .Dark, .Ghost:
                            self.color = .purple
                        case .Rock, .Steel:
                            self.color = .gray
                        case .Water, .Flying, .Ice:
                            self.color = .blue
                        default:
                            self.color = .orange
                        }
                        self.pokemonImage = pokemon[0].sprite
                        withAnimation(Animation.easeIn(duration: animationDuration)) {
                            self.xScale = 4
                            self.yScale = 4
                        }
                        
                    }
                    
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown")")
        }.resume()
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
            PokemonView(pokemonUrl: "https://pokeapi.glitch.me/v1/pokemon/1", backgroundColor: .white)
        }
    }
}
