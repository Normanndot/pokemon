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
    
    var body: some Scene {
        WindowGroup {
            PokemonListView()
                .environmentObject(listViewModel)
        }
    }
}
