//
//  NutritionalFilterViewUITests.swift
//  KetoDietApp-SwiftUITests
//
//  Created by user271428 on 5/8/25.
//

import XCTest

final class NutritionalFilterViewUITests: XCTestCase {

    let app = XCUIApplication()

        override func setUpWithError() throws {
            continueAfterFailure = false
            app.launch()
        }

        func testShowErrorWhenAddEmptyValues() throws {
            // Expecting error if no values are entered
            app.buttons["Add"].tap()
            
            let errorText = app.staticTexts["Please enter valid numbers for min and max."]
            XCTAssertTrue(errorText.waitForExistence(timeout: 2))
        }
        func testAddValidFilterShowsFilter() {
            let minField = app.textFields["MinInput"]
            let maxField = app.textFields["MaxInput"]
            let addButton = app.buttons["AddButton"]

            minField.tap()
            minField.typeText("10")

            maxField.tap()
            maxField.typeText("30")

            addButton.tap()

            let newFilter = app.staticTexts["Range: 10 - 30g"]
            XCTAssertTrue(newFilter.waitForExistence(timeout: 2))
        }

}
