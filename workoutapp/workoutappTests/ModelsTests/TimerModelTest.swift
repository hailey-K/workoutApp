//
//  TimerModelTest.swift
//  workoutappTests
//
//  Created by Chevy McMartin on 2018-04-07.
//  Copyright © 2018 hch_enterprise. All rights reserved.
//

import XCTest
@testable import workoutapp

class TimerModelTest: XCTestCase {
    
    let testTimer = TimerModel(TimerId: 1, TimerName: "My Timer", NumberOfSets: 3, HighInetensity: "00:01.00", LowIntensity: "00:03.00")
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInit_TimerNotNil() {
        XCTAssertNotNil(testTimer)
    }
    
    func testInit_TimerWithTimerId() {
        XCTAssertEqual(testTimer.TimerId, 1)
    }
    
    func testInit_TimerWithTimerName() {
        XCTAssertEqual(testTimer.TimerName, "My Timer")
    }
    
    func testInit_TimerWithNumberOfSets() {
        XCTAssertEqual(testTimer.NumberOfSets, 3)
    }
    
    func testInit_TimerWithHighIntensity() {
        XCTAssertEqual(testTimer.HighInetensity, "00:01.00")
    }
    
    func testInit_TimerWithLowIntensity() {
        XCTAssertEqual(testTimer.LowIntensity, "00:03.00")
    }
}

