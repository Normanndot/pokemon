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
        switch viewModel.fetchingPokemonList {
        case .inProgress:
            ProgressView("Hold on, we're almost there!")
                .task {
                    await viewModel.fetchInitialList()
                }
        case .completed:
            NavigationStack {
                VStack {
                    SearchBar(
                        text: $viewModel.searchText,
                        placeholder: "Search Pokèmon"
                    )
                    List {
                        ForEach(viewModel.filteredPokemons) { aPokemon in
                            NavigationLink(value: aPokemon) {
                                PokemonRow(pokemon: aPokemon)
                            }
                        }
                    }
                }
                .navigationTitle("Pokèmon")
                .navigationDestination(for: Pokemon.self) { aPokemon in
                    PokemonDetailView(pokemon: aPokemon)
                }
            }
        case .failed:
            ContentUnavailableView(
                "Internet's napping! \nTry a quick toggle.",
                systemImage: "icloud.slash"
            )
        }
    }
}
