//
//  WorkoutNoteModel.swift
//  workoutapp
//
//  Created by Hyerim on 2018-04-15.
//  Copyright © 2018 hch_enterprise. All rights reserved.
//

import Foundation

class WorkoutNoteModel
{
    var noteWorkoutId: Int32
    var workoutId: Int32
    var mark : Bool
    
    init(noteWorkoutId:Int32, workoutId: Int32, mark:Bool )
    {
        self.noteWorkoutId = noteWorkoutId
        self.workoutId = workoutId
        self.mark = mark
    }
}
