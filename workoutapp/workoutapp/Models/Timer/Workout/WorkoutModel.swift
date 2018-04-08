//
//  WorkoutModel.swift
//  workoutapp
//
//  Created by hyerim on 2018-04-07.
//  Copyright © 2018 hch_enterprise. All rights reserved.
//

import Foundation
class WorkoutModel
{
    var WorkoutId: Int32
    var WorkoutName: String
    
    init(WorkoutId:Int32, WorkoutName: String)
    {
        self.WorkoutId = WorkoutId
        self.WorkoutName = WorkoutName
    }
}
