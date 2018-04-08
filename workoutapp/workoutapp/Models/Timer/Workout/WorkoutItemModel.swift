//
//  WorkoutItemModel.swift
//  workoutapp
//
//  Created by Hailey on 2018-04-07.
//  Copyright © 2018 hch_enterprise. All rights reserved.
//
import Foundation
class WorkoutItemModel
{
   var WorkoutItemId: Int32
   var WorkoutItemName : String

    
    init(WorkoutItemId:Int32, WorkoutItemName: String)
    {
        self.WorkoutItemId = WorkoutItemId
        self.WorkoutItemName = WorkoutItemName
    }
}

