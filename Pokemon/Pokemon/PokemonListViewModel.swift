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
    @Published var isLoading: Bool = false
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
        isLoading = true
        
        Task {
            do {
                let response = try await service.fetchPokemonList()
                pokemonResponse = response
                pokemons = response.results
                isLoading = false
            } catch {
                isLoading = false
            }
        }
    }
    
    func fetchNextSetOfPokemons() async {
        isLoading = true
        
        Task {
            do {
                let response = try await service.fetchNextSetOfPokemonList(for: pokemonResponse?.next)
                pokemonResponse = response
                pokemons.append(contentsOf: response.results)
                isLoading = false
            } catch {
                isLoading = false
            }
        }
    }
}
