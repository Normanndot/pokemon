//
//  EncodableTests.swift
//  
//
//  Created by Norman D on 19/08/2024.
//

import XCTest
@testable import NetworkService

final class EncodableTests: XCTestCase {
    struct TestModel: Codable, Equatable {
        let id: Int
        let name: String
    }
    
    func testToJSONData() {
        ///Arrange
        let model = TestModel(id: 1, name: "Test")
        
        ///Act
        let data = model.toJSONData()
        
        ///Assert
        XCTAssertNotNil(data)
        
        let decodedModel = try? JSONDecoder().decode(TestModel.self, from: data!)
        
        ///Assert
        XCTAssertEqual(decodedModel, model)
    }
}
