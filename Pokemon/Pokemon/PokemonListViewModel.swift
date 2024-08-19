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
                pokemons.append(contentsOf: response.results)
                isLoading = false
            } catch {
                isLoading = false
            }
        }
    }
}

protocol PokemonListing {
    func fetchPokemonList() async throws -> PokemonResponse
    func fetchNextSetOfPokemonList(for urlString: String?) async throws -> PokemonResponse
}

class PokemonListingService: PokemonListing {
    private let service: NetworkService

    init(service: NetworkService = NetworkService()) {
        self.service = service
    }

    func fetchPokemonList() async throws -> PokemonResponse {
        try await service.fetch(request: Requests.initialList())
    }
    
    func fetchNextSetOfPokemonList(for urlString: String?) async throws -> PokemonResponse {
        guard let urlString, let url = URL(string: urlString) else {
            throw RequestError.invalidURL
        }
        
        return try await service.fetch(request: Requests.nextSetOfPokemons(for: url))

    }
}


struct PokemonResponse: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Pokemon]
}

struct Pokemon: Decodable, Identifiable {
    let id = UUID()
    let name: String
    let url: String
}
