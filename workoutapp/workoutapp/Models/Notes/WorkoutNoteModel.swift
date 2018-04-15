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
    var mark : Int32 // true : 1, false : 0
    var date : String // format : month/date/year
    var workoutName : String
    var isSelected: Bool
    
    init(noteWorkoutId:Int32, workoutId: Int32, mark:Int32, date:String, workoutName:String, isSelected:Bool)
    {
        self.noteWorkoutId = noteWorkoutId
        self.workoutId = workoutId
        self.mark = mark
        self.date = date
        self.workoutName = workoutName
        self.isSelected = isSelected
    }
}
