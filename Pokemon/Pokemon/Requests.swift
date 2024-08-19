//
//  Requests.swift
//  Pokemon
//
//  Created by Norman D on 19/08/2024.
//

import Foundation

struct BaseURL {
    static let url: String = "https://pokeapi.co/api/v2/"
}

struct Requests {
    static func initialList() -> Request<PokemonResponse> {
        .init(
            url: .init(
                path: "pokemon",
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
}

extension URL {
    init?(path: String) {
        guard var urlComponents = URLComponents(string: BaseURL.url) else { return nil }
        urlComponents.path = path
        guard let url = urlComponents.url else { return nil }
        self = url
    }
    
    init?(path: String, queryItems: [URLQueryItem] = []) {
        guard var urlComponents = URLComponents(string: BaseURL.url) else { return nil }
        urlComponents.path = path
        urlComponents.queryItems = queryItems
        guard let url = urlComponents.url else { return nil }
        self = url
    }
}
