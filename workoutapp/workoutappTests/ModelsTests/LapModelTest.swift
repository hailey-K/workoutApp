//
//  LapModelTest.swift
//  workoutappTests
//
//  Created by Chevy McMartin on 2018-04-07.
//  Copyright © 2018 hch_enterprise. All rights reserved.
//

import XCTest
@testable import workoutapp

class LapModelTest: XCTestCase {
    
    let testLap = LapModel(seq: 2, timeText: "00:00:00")
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInit_LapNotNil() {
        XCTAssertNotNil(testLap)
    }
    
    func testInit_LapWithSeq() {
        XCTAssertEqual(testLap.seq, 2)
    }
    
    func testInit_LapWithTimeText() {
        XCTAssertEqual(testLap.timeText, "00:00:00")
    }
    
}

