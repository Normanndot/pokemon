//
//  PokemonListViewModel.swift
//  Pokemon
//
//  Created by Norman D on 19/08/2024.
//

import Foundation

@Observable
class PokemonListViewModel {
    var pokemons: [Pokemon] = []
    var isLoading: Bool = false
    
    private let service: PokemonListing
    private var pokemonResponse: PokemonResponse?
    
    init(service: PokemonListing = PokemonListingService()) {
        self.service = service
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
