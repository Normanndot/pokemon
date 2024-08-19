//
//  PokemonDetailView.swift
//  Pokemon
//
//  Created by Norman D on 19/08/2024.
//

import SwiftUI

struct PokemonDetailView: View {
    let pokemon: Pokemon
    @Environment(PokemonDetailViewModel.self) var viewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if let details = viewModel.pokemonDetails {
                    VStack {
                        AsyncImage(url: details.sprites.frontDefault)
                            .frame(width: 150, height: 150)

                        Text("#\(details.id) \(details.name.capitalized)")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("Weight: \(details.weight)")
                        Text("Height: \(details.height)")
                        
                        PokemonTypesView(types: details.types)
                        PokemonStatsView(stats: details.stats)
                    }
                    .padding()
                } else {
                    ProgressView("Loading...")
                }
            }
            .task {
                await viewModel.fetchPokemonDetails(name: pokemon.name)
            }
            .navigationTitle(pokemon.name.capitalized)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
