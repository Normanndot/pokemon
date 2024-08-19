//
//  PokemonTypesView.swift
//  Pokemon
//
//  Created by Norman D on 19/08/2024.
//

import SwiftUI

struct PokemonTypesView: View {
    let types: [PokemonType]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Types:")
                .font(.headline)
            
            ForEach(types, id: \.type.name) { aPokemonType in
                HStack {
                    Text(aPokemonType.type.name.capitalized)
                    Spacer()
                }
            }
        }
        .padding()
    }
}
