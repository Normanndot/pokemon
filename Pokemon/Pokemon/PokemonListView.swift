//
//  PokemonListView.swift
//  Pokemon
//
//  Created by Norman D on 19/08/2024.
//

import SwiftUI

struct PokemonListView: View {
    @EnvironmentObject var viewModel: PokemonListViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                SearchBar(text: $viewModel.searchText, placeholder: "Search Pokèmon")
                List {
                    ForEach(viewModel.filteredPokemons) { aPokemon in
                        NavigationLink {
                            PokemonDetailView(pokemon: aPokemon)
                        } label: {
                            PokemonRow(pokemon: aPokemon)
                                .onAppear {
                                    if aPokemon == viewModel.pokemons.last {
                                        Task {
                                            await viewModel.fetchNextSetOfPokemons()
                                        }
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
            }
            .navigationTitle("Pokèmon")
        }
        .task {
            await viewModel.fetchInitialList()
        }
    }
}
