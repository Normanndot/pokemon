//
//  PokemonDetailServiceTests.swift
//  PokemonTests
//
//  Created by Norman D on 20/08/2024.
//

import XCTest
@testable import Pokemon
import NetworkService

final class PokemonDetailServiceTests: XCTestCase {
    
    private var service: PokemonDetailService!
    private var mockNetworkService: MockNetworkService!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        service = PokemonDetailService(service: mockNetworkService)
    }
    
    func testFetchPokemonDetailsSuccess() async throws {
        // Given
        let expectedDetails = PokemonDetails.mock
        let mockData = PokemonDetails.mockData
        mockNetworkService.result = .success(mockData)

        // When
        let details = try await service.fetchPokemonDetails(for: "pikachu")
        
        // Then
        XCTAssertEqual(details.id, expectedDetails.id)
        XCTAssertEqual(details.name, expectedDetails.name)
        XCTAssertEqual(details.height, expectedDetails.height)
        XCTAssertEqual(details.weight, expectedDetails.weight)
    }
    
    func testFetchPokemonDetailsFailure() async {
        // Given
        let expectedError = RequestError.noNetwork
        mockNetworkService.result = .failure(expectedError)
        
        // When
        do {
            _ = try await service.fetchPokemonDetails(for: "pikachu")
            XCTFail("Expected error not thrown")
        } catch {
            // Then
            XCTAssertEqual(error as? RequestError, expectedError)
        }
    }
}
