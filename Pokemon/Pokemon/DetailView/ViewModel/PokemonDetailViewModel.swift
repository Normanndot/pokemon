//
//  PokemonDetailViewModel.swift
//  Pokemon
//
//  Created by Norman D on 19/08/2024.
//

import Foundation

@Observable
final class PokemonDetailViewModel {
    private let service: PokemonDetailing
    private(set) var pokemonDetails: PokemonDetails?
    private(set) var fetchingPokemonDetails = FetchingPokemonDetails.inProgress

    enum FetchingPokemonDetails {
        case inProgress, completed, failed
    }
    
    init(service: PokemonDetailing = PokemonDetailService()) {
        self.service = service
    }
    
    func fetchPokemonDetails(name: String) async {
        do {
            pokemonDetails = try await service.fetchPokemonDetails(for: name)
            fetchingPokemonDetails = .completed
        } catch {
            fetchingPokemonDetails = .failed
        }
    }
}
