//
//  WorkoutNoteDB.swift
//  workoutapp
//
//  Created by Hailey on 2018-04-15.
//  Copyright © 2018 hch_enterprise. All rights reserved.
//

import Foundation
import SQLite3

class WorkoutNoteDB
{
    private func createWorkoutNoteTable()
    {
        let db = DBUtil().getConnectione()
        
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS WorkoutNote (noteWorkoutId INTEGER PRIMARY KEY AUTOINCREMENT, workoutId INTERGER, mark INTERGER, date TEXT)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
        else
        {
            print("Create Success")
        }
    }
    
    /*func insertOrUpdateWorkoutNote(workoutNote:WorkoutNoteModel)
    {
        self.createWorkoutNoteTable()
        let db = DBUtil().getConnectione()
        
        //creating a statement
        var stmt: OpaquePointer?
        //the insert query
        let queryString = "INSERT INTO WorkoutNote (workoutId, mark, date) VALUES ('" + workoutNote.workoutId + "', '" + workoutNote.mark + "', '" + workoutNote.date + "')"
        
        if sqlite3_exec(db, queryString, nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
        
        //readValues()
    }
    
    func getWorkoutListWithSelecedItem() -> [WorkoutNoteModel]{
        let db = DBUtil().getConnectione()
        var workoutNoteList = [WorkoutNoteModel]()
        //statement pointer
        var stmt:OpaquePointer?

        let queryString = "SELECT WN.* FROM Workout W LEFT JOIN WorkoutNote WN ON W.WorkoutId = WN.WorkoutId"
        
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let workoutNoteId = sqlite3_column_int(stmt, 0)
            let workoutId = sqlite3_column_int(stmt, 1)
            let mark = sqlite3_column_int(stmt, 2)
            let workoutName = "aa"
            let date = String(cString: sqlite3_column_text(stmt, 3))
            let isSelected = false
            //adding values to list
            workoutNoteList.append(WorkoutNoteModel.init(noteWorkoutId: workoutNoteId, workoutId: workoutId, mark: mark, date: date, workoutName: workoutName, isSelected: isSelected))
            //heroList.append(Hero(id: Int(id), name: String(describing: name), powerRanking: Int(powerrank)))
        }
    }*/
    
}
