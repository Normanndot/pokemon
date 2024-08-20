//
//  PokemonListViewModel.swift
//  Pokemon
//
//  Created by Norman D on 19/08/2024.
//

import Foundation

final class PokemonListViewModel: ObservableObject {
    @Published private(set) var pokemons: [Pokemon] = []
    @Published var searchText: String = ""
    @Published private(set) var fetchingPokemonList = FetchingPokemonList.inProgress

    private let service: PokemonListing
    private var pokemonResponse: PokemonResponse?

    enum FetchingPokemonList {
        case inProgress, completed, failed
    }

    init(service: PokemonListing = PokemonListingService()) {
        self.service = service
    }
    
    var filteredPokemons: [Pokemon] {
        if searchText.isEmpty {
            return pokemons
        } else {
            return pokemons.filter {
                $0.name.lowercased().contains(
                    searchText.lowercased()
                )
            }
        }
    }
    
    func fetchInitialList() async {
        do {
            let response = try await service.fetchPokemonList()
            await MainActor.run {
                self.pokemonResponse = response
                self.pokemons = response.results
                fetchingPokemonList = .completed
            }
        } catch {
            fetchingPokemonList = .failed
        }
    }
    
    func fetchNextSetOfPokemons() async {
        guard let nextUrl = pokemonResponse?.next else { return }
        do {
            let response = try await service.fetchNextSetOfPokemonList(for: nextUrl)
            await MainActor.run {
                self.pokemonResponse = response
                self.pokemons.append(contentsOf: response.results)
            }
        } catch {
            print("Failed to fetch next set of pokemons: \(error)")
        }
    }
}
