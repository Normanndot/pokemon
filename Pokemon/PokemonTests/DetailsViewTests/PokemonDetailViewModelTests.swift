//
//  PokemonDetailViewModelTests.swift
//  PokemonTests
//
//  Created by Norman D on 20/08/2024.
//

import XCTest
@testable import Pokemon

final class PokemonDetailViewModelTests: XCTestCase {
    
    var viewModel: PokemonDetailViewModel!
    var mockDetailing: MockPokemonDetailing!
    
    override func setUp() {
        super.setUp()
        mockDetailing = MockPokemonDetailing()
        viewModel = PokemonDetailViewModel(service: mockDetailing)
    }
    
    func testFetchPokemonDetailsSuccess() async {
        ///Given
        let expectedDetails = PokemonDetails.mock
        mockDetailing.result = .success(expectedDetails)
        
        ///When
        await viewModel.fetchPokemonDetails(name: "pikachu")
        
        ///Then
        XCTAssertEqual(viewModel.fetchingPokemonDetails, .completed)
        XCTAssertEqual(viewModel.pokemonDetails?.id, expectedDetails.id)
        XCTAssertEqual(viewModel.pokemonDetails?.name, expectedDetails.name)
        XCTAssertEqual(viewModel.pokemonDetails?.height, expectedDetails.height)
        XCTAssertEqual(viewModel.pokemonDetails?.weight, expectedDetails.weight)
    }
    
    func testFetchPokemonDetailsFailure() async {
        ///Given
        let expectedError = NSError(domain: "TestError", code: 1, userInfo: nil)
        mockDetailing.result = .failure(expectedError)
        
        ///When
        await viewModel.fetchPokemonDetails(name: "pikachu")
        
        ///Then
        XCTAssertNil(viewModel.pokemonDetails)
        XCTAssertEqual(viewModel.fetchingPokemonDetails, .failed)
    }
    
    func testFetchingPokemonDetailsStateInitiallyInProgress() {
        ///Given
        ///Then
        XCTAssertEqual(viewModel.fetchingPokemonDetails, .inProgress)
    }
}
