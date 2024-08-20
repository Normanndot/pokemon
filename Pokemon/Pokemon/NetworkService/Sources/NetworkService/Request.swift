//
//  Request.swift
//  Pokemon
//
//  Created by Norman D on 19/08/2024.
//

import Foundation

public struct Request<T: Decodable> {
    public let request: URLRequest
    public let responseType: T.Type
    
    public init(
        url: URL,
        httpMethod: HTTPMethod
    ) {
        var urlRequest: URLRequest {
            var request = URLRequest(
                url: url
            )
            request.httpMethod = httpMethod.string
            
            return request
        }
        
        self.request = urlRequest
        self.responseType = T.self
    }
}

extension Encodable {
    func toJSONData() -> Data? {
        try? JSONEncoder().encode(
            self
        )
    }
}
