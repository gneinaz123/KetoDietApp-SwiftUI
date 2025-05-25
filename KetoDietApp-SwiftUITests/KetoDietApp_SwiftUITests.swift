//
//  KetoDietApp_SwiftUITests.swift
//  KetoDietApp-SwiftUITests
//
//  Created by user271428 on 5/8/25.
//

import XCTest

final class KetoDietApp_SwiftUITests: XCTestCase {

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

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
