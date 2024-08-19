//
//  PokemonDetailViewModel.swift
//  Pokemon
//
//  Created by Norman D on 19/08/2024.
//

import Foundation

@Observable
class PokemonDetailViewModel {
    var pokemonDetails: PokemonDetails?
    
    private let service: PokemonDetailing
    
    init(service: PokemonDetailing = PokemonDetailService()) {
        self.service = service
    }
    
    func fetchPokemonDetails(name: String) async {
        do {
            pokemonDetails = try await service.fetchPokemonDetails(for: name)
        } catch {
            
        }
        
    }
}
