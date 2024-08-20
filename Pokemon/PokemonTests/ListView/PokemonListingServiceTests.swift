//
//  PokemonListingServiceTests.swift
//  PokemonTests
//
//  Created by Norman D on 20/08/2024.
//

import XCTest
import NetworkService
@testable import Pokemon

final class PokemonListingServiceTests: XCTestCase {
    
    var service: PokemonListingService!
    var mockNetworkService: MockNetworkService!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        service = PokemonListingService(service: mockNetworkService)
    }
    
    override func tearDown() {
        service = nil
        mockNetworkService = nil
        super.tearDown()
    }
    
    func testFetchPokemonListSuccess() async throws {
        ///Arrange
        let mockPokemonResponse = PokemonResponse(count: 1, next: nil, previous: nil, results: [Pokemon(name: "Pikachu", url: .sampleURL)])
        let mockData = try JSONEncoder().encode(mockPokemonResponse)
        mockNetworkService.result = .success(mockData)
        
        ///Act
        let response = try await service.fetchPokemonList()
        
        ///Assert
        XCTAssertEqual(
            response.results[0].name,
            mockPokemonResponse.results[0].name,
            "Expected response to be \(mockPokemonResponse), but got \(response)."
        )
    }
    
    func testFetchPokemonListFailure() async throws {
        ///Arrange
        mockNetworkService.result = .failure(.clientError)
        
        do {
            ///Act
            _ = try await service.fetchPokemonList()
            XCTFail("Expected error, but fetchPokemonList succeeded.")
        } catch {
            ///Assert
            XCTAssertEqual(error as? RequestError, .clientError, "Expected RequestError.clientError, but got \(error).")
        }
    }
    
    func testFetchNextSetOfPokemonListSuccess() async throws {
        ///Arrange
        let mockPokemonResponse = PokemonResponse(count: 1, next: .sampleURL, previous: nil, results: [Pokemon(name: "Pikachu", url: .sampleURL), Pokemon(name: "Bulbasaur", url: .sampleURL)])
        let mockData = try JSONEncoder().encode(mockPokemonResponse)
        mockNetworkService.result = .success(mockData)
        
        ///Act
        let urlString = "https://example.com/next-pokemon"
        let response = try await service.fetchNextSetOfPokemonList(for: urlString)
        ///Assert
        XCTAssertEqual(
            response.results[1].name,
            mockPokemonResponse.results[1].name,
            "Expected response to be \(mockPokemonResponse), but got \(response)."
        )
    }
    
    func testFetchNextSetOfPokemonListInvalidURL() async throws {
        ///Arrange
        let urlString: String? = nil
        
        do {
            ///Act
            _ = try await service.fetchNextSetOfPokemonList(for: urlString)
            XCTFail("Expected error, but fetchNextSetOfPokemonList succeeded.")
        } catch {
            ///Assert
            XCTAssertEqual(
                error as? RequestError,
                .invalidURL,
                "Expected RequestError.invalidURL, but got \(error)."
            )
        }
    }
    
    func testFetchNextSetOfPokemonListFailure() async throws {
        ///Arrange
        mockNetworkService.result = .failure(.serverError)
        
        let urlString = "https://example.com/next-pokemon"
        do {
            ///Act
            _ = try await service.fetchNextSetOfPokemonList(for: urlString)
            XCTFail("Expected error, but fetchNextSetOfPokemonList succeeded.")
        } catch {
            ///Assert
            XCTAssertEqual(
                error as? RequestError,
                .serverError,
                "Expected RequestError.serverError, but got \(error)."
            )
        }
    }
}
