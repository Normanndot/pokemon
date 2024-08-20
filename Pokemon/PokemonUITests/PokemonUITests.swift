//
//  PokemonUITests.swift
//  PokemonUITests
//
//  Created by Norman D on 19/08/2024.
//

import XCTest

final class PokemonUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }
    
    func testPokemonListViewDisplaysCorrectly() throws {
        let app = XCUIApplication()
        let collectionViewsQuery = app.collectionViews

        app.swipeUp(to: collectionViewsQuery.buttons["Diglett"])
        collectionViewsQuery.buttons["Diglett"].tap()
        XCTAssert(app.staticTexts["Attack"].exists)
    }
}

extension XCUIApplication {
    func swipeUp(to element: XCUIElement) {
        var noOfSwipes = 0
        while !element.exists && noOfSwipes < 5 {
            swipeUp()
            noOfSwipes += 1
        }
    }
}
