//
//  PokemonResponse.swift
//  Pokemon
//
//  Created by Norman D on 19/08/2024.
//

import Foundation

struct PokemonResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Pokemon]
}
