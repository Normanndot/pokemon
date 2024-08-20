//
//  PokemonDetailView.swift
//  Pokemon
//
//  Created by Norman D on 19/08/2024.
//

import SwiftUI

struct PokemonDetailView: View {
    let pokemon: Pokemon
    @State private var viewModel = PokemonDetailViewModel()
    
    var body: some View {
        ScrollView {
            switch viewModel.fetchingPokemonDetails {
            case .inProgress:
                ProgressView("Hold on, we're almost there!")
                    .task {
                        await viewModel.fetchPokemonDetails(name: pokemon.name)
                    }
            case .completed:
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
            case .failed:
                ContentUnavailableView(
                    "Internet's napping! \nTry a quick toggle.",
                    systemImage: "icloud.slash"
                )
            }
        }
        .navigationTitle(pokemon.name.capitalized)
        .navigationBarTitleDisplayMode(.inline)
    }
}
