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
        ///Arrange
        let expectedDetails = PokemonDetails.mock
        let mockData = PokemonDetails.mockData
        mockNetworkService.result = .success(mockData)

        //Act
        let details = try await service.fetchPokemonDetails(for: "pikachu")
        
        //Assert
        XCTAssertEqual(details.id, expectedDetails.id)
        XCTAssertEqual(details.name, expectedDetails.name)
        XCTAssertEqual(details.height, expectedDetails.height)
        XCTAssertEqual(details.weight, expectedDetails.weight)
    }
    
    func testFetchPokemonDetailsFailure() async {
        ///Arrange
        let expectedError = RequestError.noNetwork
        mockNetworkService.result = .failure(expectedError)
        
        ///Act
        do {
            _ = try await service.fetchPokemonDetails(for: "pikachu")
            XCTFail("Expected error not thrown")
        } catch {
            ///Assert
            XCTAssertEqual(error as? RequestError, expectedError)
        }
    }
}
