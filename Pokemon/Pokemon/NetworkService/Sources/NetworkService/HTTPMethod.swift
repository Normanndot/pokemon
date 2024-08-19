//
//  HTTPMethod.swift
//  Pokemon
//
//  Created by Norman D on 19/08/2024.
//

import Foundation

public enum HTTPMethod {
    case get
    
    var string: String {
        switch self {
            case .get: return "get"
        }
    }
}
