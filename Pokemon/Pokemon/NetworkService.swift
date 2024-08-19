//
//  NetworkService.swift
//  Pokemon
//
//  Created by Norman D on 19/08/2024.
//

import Foundation

public protocol NetworkServiceable {
    func fetch<T>(
        request: Request<T>
    ) async throws -> T
}

public class NetworkService: NetworkServiceable {
    private let session: URLSession
    private let decoder: JSONDecoder
    
    public init(
        session: URLSession = .shared,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.session = session
        self.decoder = decoder
    }
    
    public func fetch<T>(
        request: Request<T>
    ) async throws -> T where T : Decodable {
        do {
            let (
                data,
                response
            ) = try await session.data(
                for: request.request
            )
            
            guard let response = response as? HTTPURLResponse else {
                throw RequestError.invalidURL
            }
            
            guard let decodedResponse = try? decoder.decode(
                request.responseType,
                from: data
            ) else {
                if data.isEmpty {
                    return String() as! T
                }
                throw RequestError.decode
            }
            
            return decodedResponse
        } catch {
            if let error = error as? RequestError {
                throw error
            }
            
            let error = error as NSError
            if error.domain == NSURLErrorDomain, 
                error.code == NSURLErrorNotConnectedToInternet {
                throw RequestError.noNetwork
            } else {
                throw RequestError.unKnown
            }
        }
    }
}
