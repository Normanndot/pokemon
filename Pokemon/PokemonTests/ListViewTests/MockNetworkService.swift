//
//  MockNetworkService.swift
//  PokemonTests
//
//  Created by Norman D on 20/08/2024.
//

import Foundation
import NetworkService

final class MockNetworkService: NetworkServiceable {
    var result: Result<Data, RequestError>!
    
    func fetch<T>(request: Request<T>) async throws -> T where T: Decodable {
        switch result {
        case .success(let data):
            return try JSONDecoder().decode(request.responseType, from: data)
        case .failure(let error):
            throw error
        case .none:
            fatalError("MockNetworkService result not set")
        }
    }
}
