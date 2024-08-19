//
//  PokemonApp.swift
//  Pokemon
//
//  Created by Norman D on 19/08/2024.
//

import SwiftUI

@main
struct PokemonApp: App {
    @StateObject private var listViewModel = PokemonListViewModel()
    @State private var detailsViewModel = PokemonDetailViewModel()
    
    var body: some Scene {
        WindowGroup {
            PokemonListView()
                .environmentObject(listViewModel)
                .environment(detailsViewModel)
        }
    }
}
