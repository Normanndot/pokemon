//
//  MockPokemonDetailing.swift
//  PokemonTests
//
//  Created by Norman D on 20/08/2024.
//

import Foundation
@testable import Pokemon

final class MockPokemonDetailing: PokemonDetailing {
    var result: Result<PokemonDetails, Error>?
    
    func fetchPokemonDetails(for pokemonName: String) async throws -> PokemonDetails {
        if let result = result {
            return try result.get()
        } else {
            throw NSError(domain: "MockError", code: 0, userInfo: nil)
        }
    }
}
