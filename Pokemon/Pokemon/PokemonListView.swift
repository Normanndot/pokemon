//
//  PokemonListView.swift
//  Pokemon
//
//  Created by Norman D on 19/08/2024.
//

import SwiftUI

struct PokemonListView: View {
    @Environment(PokemonListViewModel.self) private var viewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.pokemons) { aPokemon in
                    PokemonRow(pokemon: aPokemon)
                        .onAppear {
                            if aPokemon == viewModel.pokemons.last {
                                Task {
                                    await viewModel.fetchNextSetOfPokemons()
                                }
                            }
                        }
                }
                
                if viewModel.isLoading {
                    ProgressView()
                        .foregroundStyle(.black)
                        .padding()
                }
            }
            .navigationTitle("Pokèmon")
        }
        .task {
            await viewModel.fetchInitialList()
        }
    }
}
