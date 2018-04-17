//
//  WorkoutListModelTest.swift
//  workoutappTests
//
//  Created by Chevy McMartin on 2018-04-08.
//  Copyright © 2018 hch_enterprise. All rights reserved.
//

import XCTest
@testable import workoutapp

class WorkoutListModelTest: XCTestCase {
    
    let testWorkoutList = WorkoutListModel(WorkoutListId: 1, WorkoutItemId: 2, workoutId: 3)
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInit_WorkoutListNotNil() {
        XCTAssertNotNil(testWorkoutList)
    }
    
    func testInit_WorkoutListWithWorkoutListId() {
        XCTAssertEqual(testWorkoutList.WorkoutListId, 1)
    }
    
    func testInit_WorkoutListWithWorkoutItemId() {
        XCTAssertEqual(testWorkoutList.WorkoutItemId, 2)
    }
    
    func testInit_WorkoutListWithworkoutId() {
        XCTAssertEqual(testWorkoutList.workoutId, 3)
    }
}

