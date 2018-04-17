//
//  WorkoutModelTest.swift
//  workoutappTests
//
//  Created by Chevy McMartin on 2018-04-08.
//  Copyright © 2018 hch_enterprise. All rights reserved.
//

import XCTest
@testable import workoutapp

class WorkoutModelTest: XCTestCase {
    
    let testWorkout = WorkoutModel(WorkoutId: 1, WorkoutName: "Buns 'o Steel")
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInit_WorkoutNotNil() {
        XCTAssertNotNil(testWorkout)
    }
    
    func testInit_WorkoutWithWorkoutId() {
        XCTAssertEqual(testWorkout.WorkoutId, 1)
    }
    
    func testInit_WorkoutWithWorkoutName() {
        XCTAssertEqual(testWorkout.WorkoutName, "Buns 'o Steel")
    }
    
}

