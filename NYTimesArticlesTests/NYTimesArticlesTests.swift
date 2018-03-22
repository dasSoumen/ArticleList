//
//  NYTimesArticlesTests.swift
//  NYTimesArticlesTests
//
//  Created by Soumen Das on 21/03/18.
//  Copyright © 2018 NYTimes. All rights reserved.
//

import XCTest
@testable import NYTimesArticles

class NYTimesArticlesTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // MARK: - API Test
    func testArticleListApi() {
        // Create an expectation for the task.
        let expectationAPISuccess = expectation(description: "API Success")
        NYTRequestCoordinator.coordinator.getMostPopularArticles(withSuccess: { (response) in
            debugPrint("Success")
            // Fulfill the expectation to indicate that the task has finished successfully.
            expectationAPISuccess.fulfill()
        }, andFailure: { (error) in
            _ = expectationAPISuccess.isInverted
            XCTAssert(true, "API Call Failed")
        })
        // Wait until the expectation is fulfilled, with a timeout of 30 seconds.
        waitForExpectations(timeout: 30, handler: nil)
    }
}
