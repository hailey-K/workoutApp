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
    
    func insertOrUpdateWorkoutNote(workoutNote:WorkoutNoteModel)
    {
        self.createWorkoutNoteTable()
        let db = DBUtil().getConnectione()
        
        //creating a statement
        var stmt: OpaquePointer?
        
        let countQueryString = "SELECT COUNT(*) FROM WorkoutNote WHERE date = '" + workoutNote.date + "'"
        

        if sqlite3_prepare(db, countQueryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            //return workoutNoteList
        }
        else{
            var workoutNoteCount = 0
            while(sqlite3_step(stmt) == SQLITE_ROW){
                workoutNoteCount = Int(sqlite3_column_int(stmt, 0))
                break
            }
            
            var queryString = String()
            if(workoutNoteCount == 0){
                //the insert query
                queryString = "INSERT INTO WorkoutNote (workoutId, mark, date) VALUES ('\(workoutNote.workoutId)', '\(workoutNote.mark)', '\(workoutNote.date)')"
            }
            else{
                queryString = "UPDATE WorkoutNote SET workoutId = '\(workoutNote.workoutId)' WHERE date = '\(workoutNote.date)'"
            }
            
            if sqlite3_exec(db, queryString, nil, nil, nil) != SQLITE_OK {
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("error insertOrUpdate table: \(errmsg)")
            }
            
            sqlite3_finalize(stmt);
            sqlite3_close(db);
        }
        
        
        //readValues()
    }
    
    func getWorkoutListWithSelecedItem(selectedDate:String) -> [WorkoutNoteModel]{
        self.createWorkoutNoteTable()
        let db = DBUtil().getConnectione()
        var workoutNoteList = [WorkoutNoteModel]()
        //statement pointer
        var stmt:OpaquePointer?

        let queryString = "SELECT W.WorkoutId, W.WorkoutName, IFNULL(WN.noteWorkoutId, 0) noteWorkoutId, IFNULL(WN.mark, 0) mark, IFNULL(WN.date, '') date FROM Workout W LEFT JOIN (SELECT * FROM WorkoutNote WHERE date = '" + selectedDate + "') WN ON W.WorkoutId = WN.workoutId"

        //preparing the query
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return workoutNoteList
        }

        while(sqlite3_step(stmt) == SQLITE_ROW){
            let workoutId = sqlite3_column_int(stmt, 0)
            let workoutName = String(cString: sqlite3_column_text(stmt, 1))
            let noteWorkoutId = sqlite3_column_int(stmt, 2)
            let mark = sqlite3_column_int(stmt, 3)
            let date = String(cString: sqlite3_column_text(stmt, 4))
            let isSelected = (date != "") ? true : false
            //adding values to list
            workoutNoteList.append(WorkoutNoteModel.init(noteWorkoutId: noteWorkoutId, workoutId: workoutId, mark: mark, date: date, workoutName: workoutName, isSelected: isSelected))
        }
        
        return workoutNoteList
    }
    
}
