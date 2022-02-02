//
//  Tests_macOS.swift
//  Tests macOS
//
//  Created by Katelyn Lydeen on 2/1/22.
//

import XCTest

class Tests_macOS: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    
    func testSumInitialization() async {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let N = 5
            
        let mySum = SimpleSeries()
        let _ = await mySum.initWithN(passedN: N)
            
        let sUp = mySum.sUp
        let sDown = mySum.sDown
        XCTAssertEqual(sUp, 2.283333333333, accuracy: 1.0E-7, "Was not equal to this resolution.")
        XCTAssertEqual(sDown, 2.283333333333, accuracy: 1.0E-7, "Was not equal to this resolution.")
    }
    
    func testCalculateSUp() async {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let N = 5
        let mySum = SimpleSeries()
        let sUp = await mySum.calculateSUp(N: N)
        XCTAssertEqual(sUp, 2.283333333333, accuracy: 1.0E-7, "Was not equal to this resolution.")
    }
    
    func testCalculateSDown() async {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let N = 5
        let mySum = SimpleSeries()
        let sDown = await mySum.calculateSDown(N: N)
        XCTAssertEqual(sDown, 2.283333333333, accuracy: 1.0E-7, "Was not equal to this resolution.")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
