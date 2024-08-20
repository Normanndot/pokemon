//
//  PokemonStat.swift
//  Pokemon
//
//  Created by Norman D on 19/08/2024.
//

import Foundation

struct PokemonStat: Codable {
    let baseStat: Int
    let stat: StatName
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case stat
    }
}

struct StatName: Codable {
    let name: String
}
