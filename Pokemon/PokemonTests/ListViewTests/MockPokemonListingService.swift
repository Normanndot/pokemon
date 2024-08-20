//
//  MockPokemonListingService.swift
//  PokemonTests
//
//  Created by Norman D on 20/08/2024.
//

import Foundation
@testable import Pokemon

final class MockPokemonListing: PokemonListing {
    var shouldReturnError = false
    var mockResponse: PokemonResponse?
    
    func fetchPokemonList() async throws -> PokemonResponse {
        if shouldReturnError {
            throw NSError(domain: "", code: -1, userInfo: nil)
        }
        return mockResponse ?? PokemonResponse(count: 0, next: nil, previous: nil, results: [])
    }
    
    func fetchNextSetOfPokemonList(for url: String?) async throws -> PokemonResponse {
        if shouldReturnError {
            throw NSError(domain: "", code: -1, userInfo: nil)
        }
        return mockResponse ?? PokemonResponse(count: 0, next: nil, previous: nil, results: [])
    }
}
