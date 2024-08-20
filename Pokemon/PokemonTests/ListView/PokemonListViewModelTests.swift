//
//  PokemonListViewModelTests.swift
//  PokemonTests
//
//  Created by Norman D on 20/08/2024.
//

import XCTest
@testable import Pokemon

extension String {
    static let sampleURL = "https://pokemon.com/v2/1"
}

final class PokemonListViewModelTests: XCTestCase {
    var viewModel: PokemonListViewModel!
    var mockService: MockPokemonListing!
    
    override func setUp() {
        super.setUp()
        mockService = MockPokemonListing()
        viewModel = PokemonListViewModel(service: mockService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }
    
    func testFetchInitialListSuccess() async {
        // Given
        let mockPokemons = [Pokemon(name: "Pikachu", url: .sampleURL), Pokemon(name: "Bulbasaur", url: .sampleURL)]
        mockService.mockResponse = PokemonResponse(count: 2, next: nil, previous: nil, results: mockPokemons)
        
        // When
        await viewModel.fetchInitialList()
        
        // Then
        XCTAssertEqual(viewModel.pokemons, mockPokemons)
    }
    
    func testFetchInitialListFailure() async {
        // Given
        mockService.shouldReturnError = true
        
        // When
        await viewModel.fetchInitialList()
        
        // Then
        XCTAssertTrue(viewModel.pokemons.isEmpty)
    }
    
    func testFilteredPokemonsWithSearchText() async {
        // Given
        let pokemons = [Pokemon(name: "Pikachu", url: "url1"), Pokemon(name: "Bulbasaur", url: "url2")]
        mockService.mockResponse = PokemonResponse(count: 2, next: nil, previous: nil, results: pokemons)
        await viewModel.fetchInitialList()

        viewModel.searchText = "pik"
        
        // When
        let filteredPokemons = viewModel.filteredPokemons
        
        // Then
        XCTAssertEqual(filteredPokemons, [pokemons[0]])
    }
    
    func testFetchNextSetOfPokemonsSuccess() async {
        // Given
        let initialPokemons = [Pokemon(name: "Pikachu", url: "url1")]
        mockService.mockResponse = PokemonResponse(count: 1, next: .sampleURL, previous: nil, results: initialPokemons)
        
        // When
        await viewModel.fetchInitialList()

        // Then
        XCTAssertEqual(viewModel.pokemons, initialPokemons)
        
        // Given
        let nextPokemons = [Pokemon(name: "Bulbasaur", url: "url2")]
        mockService.mockResponse = PokemonResponse(count: 1, next: nil, previous: nil, results: nextPokemons)
        
        // When
        await viewModel.fetchNextSetOfPokemons()
        
        // Then
        XCTAssertEqual(viewModel.pokemons, initialPokemons + nextPokemons)
    }
    
    func testFetchNextSetOfPokemonsFailure() async {
        // Given
        let initialPokemons = [Pokemon(name: "Pikachu", url: "url1")]
        mockService.mockResponse = PokemonResponse(count: 1, next: .sampleURL, previous: nil, results: initialPokemons)
        await viewModel.fetchInitialList()

        // When
        mockService.shouldReturnError = true
        await viewModel.fetchNextSetOfPokemons()
        
        // Then
        XCTAssertEqual(viewModel.pokemons.count, 1) // No new pokemons should be added
    }
}
