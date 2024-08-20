//
//  URLSessionMock.swift
//
//
//  Created by Norman D on 19/08/2024.
//

import Foundation
@testable import NetworkService

final class URLSessionMock: URLSessionProtocol {
    var nextData: Data?
    var nextResponse: URLResponse?
    var nextError: Error?
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error = nextError {
            throw error
        }
        
        let data = nextData ?? Data()
        let response = nextResponse ?? URLResponse()
        return (data, response)
    }
}
