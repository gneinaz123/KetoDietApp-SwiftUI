//
//  KetoDietApp_SwiftUnitTests.swift
//  KetoDietApp-SwiftUnitTests
//
//  Created by user271428 on 5/8/25.
//

import XCTest
@testable import KetoDietApp_SwiftUI

final class  KetoDietApp_SwiftUnitTests : XCTestCase {

    var viewModel: NutritionalFilterViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = NutritionalFilterViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }
    

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testAddValidFilter() throws {
        viewModel.selectedCategory = .protein
        viewModel.minAmount = "20"
        viewModel.maxAmount = "40"
            
        viewModel.addFilter()
            
        XCTAssertEqual(viewModel.filters.count, 1)
        XCTAssertEqual(viewModel.filters.first?.category, .protein)
        XCTAssertEqual(viewModel.filters.first?.min, 20)
        XCTAssertEqual(viewModel.filters.first?.max, 40)
        XCTAssertNil(viewModel.errorMessage)
    }
    func testAddFilterWithInvalidRange() throws {
        viewModel.selectedCategory = .fat
        viewModel.minAmount = "50"
        viewModel.maxAmount = "10" // Invalid: min > max
            
        viewModel.addFilter()
            
        XCTAssertEqual(viewModel.filters.count, 0)
        XCTAssertEqual(viewModel.errorMessage, "Min value cannot be greater than max value.")
    }

    func testAddFilterWithNonNumericInput() throws {
        viewModel.selectedCategory = .carbohydrates
        viewModel.minAmount = "abc"
        viewModel.maxAmount = "xyz"
            
        viewModel.addFilter()
            
        XCTAssertEqual(viewModel.filters.count, 0)
        XCTAssertEqual(viewModel.errorMessage, "Please enter valid numbers for min and max.")
    }

    func testRemoveFilter() throws {
        viewModel.selectedCategory = .protein
        viewModel.minAmount = "10"
        viewModel.maxAmount = "20"
        viewModel.addFilter()
            
        let filter = viewModel.filters.first!
        viewModel.removeFilters(filter)
            
        XCTAssertTrue(viewModel.filters.isEmpty)
    }

}
