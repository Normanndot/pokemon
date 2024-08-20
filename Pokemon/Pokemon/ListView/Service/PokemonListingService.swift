//
//  PokemonListingService.swift
//  Pokemon
//
//  Created by Norman D on 19/08/2024.
//

import Foundation
import NetworkService

protocol PokemonListing {
    func fetchPokemonList() async throws -> PokemonResponse
    func fetchNextSetOfPokemonList(for urlString: String?) async throws -> PokemonResponse
}

class PokemonListingService: PokemonListing {
    private let service: NetworkServiceable

    init(service: NetworkServiceable = NetworkService()) {
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
