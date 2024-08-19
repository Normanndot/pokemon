//
//  RequestError.swift
//  Pokemon
//
//  Created by Norman D on 19/08/2024.
//

import Foundation

public enum RequestError: Error {
    case decode
    case invalidURL
    case unKnown
    case noNetwork
    case redirection
    case clientError
    case serverError
    case unExpectedStatusCode
}
