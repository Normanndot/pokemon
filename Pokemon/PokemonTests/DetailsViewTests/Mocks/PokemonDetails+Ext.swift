//
//  PokemonDetails+Ext.swift
//  PokemonTests
//
//  Created by Norman D on 20/08/2024.
//

import Foundation
@testable import Pokemon

extension PokemonDetails {
    static var mock: PokemonDetails {
        return PokemonDetails(
            id: 1,
            name: "Pikachu",
            height: 4,
            weight: 60,
            types: [PokemonType(type: PokemonTypeName(name: "electric"))],
            sprites: PokemonSprites(backDefault: nil, backFemale: nil, backShiny: nil, backShinyFemale: nil, frontDefault: nil, frontFemale: nil, frontShiny: nil, frontShinyFemale: nil),
            stats: [PokemonStat(baseStat: 55, stat: StatName(name: "speed"))]
        )
    }
    
    static var mockData: Data {
        let details = PokemonDetails.mock
        let encoder = JSONEncoder()
        return try! encoder.encode(details)
    }
}
