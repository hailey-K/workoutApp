//
//  WorkoutListModel.swift
//  workoutapp
//
//  Created by hyerim on 2018-04-07.
//  Copyright © 2018 hch_enterprise. All rights reserved.
//

import Foundation
class WorkoutListModel
{
var WorkoutListId: Int32
var WorkoutItemId: Int32
var WorkoutId: Int32

    init(WorkoutListId:Int32, WorkoutItemId: Int32,WorkoutId:Int32)
{
    self.WorkoutListId = WorkoutListId
    self.WorkoutItemId = WorkoutItemId
    self.WorkoutId = WorkoutId
}
}
