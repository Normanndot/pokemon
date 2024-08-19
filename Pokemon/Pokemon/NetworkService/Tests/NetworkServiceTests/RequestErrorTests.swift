//
//  RequestErrorTests.swift
//  
//
//  Created by Norman D on 19/08/2024.
//

import XCTest
@testable import NetworkService

final class RequestErrorTests: XCTestCase {
    func testRequestErrorEnum() {
        XCTAssertNotNil(RequestError.decode)
        XCTAssertNotNil(RequestError.invalidURL)
        XCTAssertNotNil(RequestError.unKnown)
        XCTAssertNotNil(RequestError.noNetwork)
        XCTAssertNotNil(RequestError.redirection)
        XCTAssertNotNil(RequestError.clientError)
        XCTAssertNotNil(RequestError.serverError)
        XCTAssertNotNil(RequestError.unExpectedStatusCode)
    }
}
