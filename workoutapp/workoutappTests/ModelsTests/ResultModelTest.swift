//
//  ResultModelTest.swift
//  workoutappTests
//
//  Created by Chevy McMartin on 2018-04-07.
//  Copyright © 2018 hch_enterprise. All rights reserved.
//

import XCTest
@testable import workoutapp

class ResultModelTest: XCTestCase {
    
    let testResult = ResultModel(isSuccess: true, errorMsg: "Error")
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInit_ResultNotNil() {
        XCTAssertNotNil(testResult)
    }
    
    func testInit_ResultWithIsSuccess() {
        XCTAssertEqual(testResult.isSuccess, true)
    }
    
    func testInit_ResultNil() {
        let testResult = ResultModel(isSuccess: true, errorMsg:     nil)
        
        XCTAssertNil(testResult.errorMsg)
    }
    
    func testInit_ResultWithErroMsg() {
        XCTAssertEqual(testResult.errorMsg, "Error")
    }
    
}

