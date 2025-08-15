//
//  StoresPageViewUITest.swift
//  COOLBLUE
//
//  Created by Clinton on 18/07/2025.
//

import XCTest
@testable import COOLBLUE

class StoresPageViewUITest: XCTestCase {
    private var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
        app.launch()
    }

    func testNavigateToStoreDetailAndBack() {
        let storeCard = app.buttons["StoreCard_The Hague"]
        XCTAssertTrue(storeCard.waitForExistence(timeout: 5))
        storeCard.tap()


        let storeCardRotterdam = app.buttons["StoreCard_Rotterdam Central"]
        XCTAssertTrue(storeCardRotterdam.waitForExistence(timeout: 5))
        storeCardRotterdam.tap()

        let backButton = app.buttons["BackButtonStoreDetail"]
        XCTAssertTrue(backButton.waitForExistence(timeout: 5))
        backButton.tap()
        XCTAssertTrue(backButton.waitForExistence(timeout: 2))
        backButton.tap()

        XCTAssertTrue(storeCard.waitForExistence(timeout: 5))
    }
}
