//
//  Pokemon.swift
//  Pokemon
//
//  Created by Norman D on 19/08/2024.
//

import Foundation

struct Pokemon: Decodable, Identifiable {
    let id = UUID()
    let name: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case name, url
    }
}
