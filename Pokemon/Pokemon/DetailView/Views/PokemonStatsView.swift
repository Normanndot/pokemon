//
//  PokemonStatsView.swift
//  Pokemon
//
//  Created by Norman D on 19/08/2024.
//

import SwiftUI

struct PokemonStatsView: View {
    let stats: [PokemonStat]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Stats:")
                .font(.headline)
            
            ForEach(stats, id: \.stat.name) { stat in
                HStack {
                    Text(stat.stat.name.capitalized)
                    Spacer()
                    Text("\(stat.baseStat)")
                }
            }
        }
        .padding()
    }
}
