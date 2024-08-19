//
//  PokemonListViewModel.swift
//  Pokemon
//
//  Created by Norman D on 19/08/2024.
//

import Foundation

@MainActor
class PokemonListViewModel: ObservableObject {
    @Published var pokemons: [Pokemon] = []
    @Published var searchText: String = ""

    private let service: PokemonListing
    private var pokemonResponse: PokemonResponse?
    
    init(service: PokemonListing = PokemonListingService()) {
        self.service = service
    }
    
    var filteredPokemons: [Pokemon] {
            if searchText.isEmpty {
                return pokemons
            } else {
                return pokemons.filter {
                    $0.name.lowercased().contains(
                        searchText.lowercased()
                    )
                }
            }
        }
    
    func fetchInitialList() async {
        Task {
            do {
                let response = try await service.fetchPokemonList()
                pokemonResponse = response
                pokemons = response.results
            } catch {
            }
        }
    }
    
    func fetchNextSetOfPokemons() async {
        Task {
            do {
                let response = try await service.fetchNextSetOfPokemonList(for: pokemonResponse?.next)
                pokemonResponse = response
                pokemons.append(contentsOf: response.results)
            } catch {
            }
        }
    }
}
