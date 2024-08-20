//
//  PokemonType.swift
//  Pokemon
//
//  Created by Norman D on 19/08/2024.
//

import Foundation

struct PokemonType: Codable {
    let type: PokemonTypeName
}

struct PokemonTypeName: Codable {
    let name: String
}
