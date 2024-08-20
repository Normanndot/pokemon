//
//  URL+Ext.swift
//  Pokemon
//
//  Created by Norman D on 20/08/2024.
//

import Foundation

extension URL {
    init?(path: String) {
        guard var urlComponents = URLComponents(string: BaseURL.url) else { return nil }
        urlComponents.path.append(path)
        guard let url = urlComponents.url else { return nil }
        self = url
    }
    
    init?(queryItems: [URLQueryItem] = []) {
        guard var urlComponents = URLComponents(string: BaseURL.url) else { return nil }
        urlComponents.queryItems = queryItems
        guard let url = urlComponents.url else { return nil }
        self = url
    }
}
