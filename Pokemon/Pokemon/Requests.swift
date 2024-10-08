//
//  Requests.swift
//  Pokemon
//
//  Created by Norman D on 19/08/2024.
//

import Foundation
import NetworkService

struct BaseURL {
    static let url: String = "https://pokeapi.co/api/v2/pokemon/"
}

struct Requests {
    static func initialList() -> Request<PokemonResponse> {
        .init(
            url: .init(
                queryItems: [
                    URLQueryItem(
                        name: "limit",
                        value: "50"
                    ),
                    URLQueryItem(
                        name: "offset",
                        value: "0"
                    )
                ]
            )!,
            httpMethod: .get
        )
    }
    
    static func nextSetOfPokemons(for url: URL) -> Request<PokemonResponse> {
        .init(url: url, httpMethod: .get)
    }
    
    static func pokemonDetails(of name: String) -> Request<PokemonDetails> {
        .init(url: .init(path: "\(name)")!, httpMethod: .get)
    }
}
