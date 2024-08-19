//
//  PokemonDetails.swift
//  Pokemon
//
//  Created by Norman D on 19/08/2024.
//

import Foundation

struct PokemonDetails: Decodable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let types: [PokemonType]
    let sprites: PokemonSprites
    let stats: [PokemonStat]
}

struct PokemonType: Decodable {
    let type: PokemonTypeName
}

struct PokemonTypeName: Decodable {
    let name: String
}

struct PokemonSprites: Decodable {
    let backDefault: URL?
    let backFemale: URL?
    let backShiny: URL?
    let backShinyFemale: URL?
    let frontDefault: URL?
    let frontFemale: URL?
    let frontShiny: URL?
    let frontShinyFemale: URL?
    
    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backFemale = "back_female"
        case backShiny = "back_shiny"
        case backShinyFemale = "back_shiny_female"
        case frontDefault = "front_default"
        case frontFemale = "front_female"
        case frontShiny = "front_shiny"
        case frontShinyFemale = "front_shiny_female"
    }
}

struct PokemonStat: Decodable {
    let baseStat: Int
    let stat: StatName
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case stat
    }
}

struct StatName: Decodable {
    let name: String
}
