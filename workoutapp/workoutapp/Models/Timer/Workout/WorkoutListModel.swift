//
//  WorkoutListModel.swift
//  workoutapp
//
//  Created by Hyerim on 2018-04-07.
//  Copyright © 2018 hch_enterprise. All rights reserved.
//

import Foundation
class WorkoutListModel
{
var WorkoutListId: Int32
var WorkoutItemId: Int32
var workoutId: Int32

    init(WorkoutListId:Int32, WorkoutItemId: Int32,workoutId:Int32)
{
    self.WorkoutListId = WorkoutListId
    self.WorkoutItemId = WorkoutItemId
    self.workoutId = workoutId
}
}
