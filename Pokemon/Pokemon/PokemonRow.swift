//
//  PokemonRow.swift
//  Pokemon
//
//  Created by Norman D on 19/08/2024.
//

import SwiftUI

struct PokemonRow: View {
    let pokemon: Pokemon
    var body: some View {
        Text(pokemon.name.capitalized)
            .padding()
    }
}
