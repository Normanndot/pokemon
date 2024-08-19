//
//  PokemonDetailService.swift
//  Pokemon
//
//  Created by Norman D on 19/08/2024.
//

import Foundation
import NetworkService

protocol PokemonDetailing {
    func fetchPokemonDetails(for pokemonName: String) async throws -> PokemonDetails
}

class PokemonDetailService: PokemonDetailing {
    private let service: NetworkService

    init(service: NetworkService = NetworkService()) {
        self.service = service
    }
    
    func fetchPokemonDetails(for pokemonName: String) async throws -> PokemonDetails {
        try await service.fetch(request: Requests.pokemonDetails(of: pokemonName))
    }
}
