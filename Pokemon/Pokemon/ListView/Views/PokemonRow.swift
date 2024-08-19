//
//  PokemonRow.swift
//  Pokemon
//
//  Created by Norman D on 19/08/2024.
//

import SwiftUI

struct PokemonRow: View {
    let pokemon: Pokemon
    @EnvironmentObject var viewModel: PokemonListViewModel
    
    var body: some View {
        Text(pokemon.name.capitalized)
            .onAppear {
                if pokemon == viewModel.pokemons.last {
                    Task {
                        await viewModel.fetchNextSetOfPokemons()
                    }
                }
            }
            .padding()
    }
}
