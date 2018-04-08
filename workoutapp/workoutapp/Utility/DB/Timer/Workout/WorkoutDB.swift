//
//  WorkoutDB.swift
//  workoutapp
//
//  Created by Hailey on 2018-04-07.
//  Copyright © 2018 hch_enterprise. All rights reserved.
//

import Foundation
 import SQLite3
 
 class WorkoutDB
{
    private func createWorkoutTable()
    {
        let db = DBUtil().getConnectione()
        
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Workout (WorkoutId INTEGER PRIMARY KEY AUTOINCREMENT, WorkoutName TEXT)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
        else
        {
            print("Create Success")
        }
    }
    
    func insertWorkout(workoutModel:WorkoutModel)
    {
        self.createWorkoutTable()
        let db = DBUtil().getConnectione()
        
        //creating a statement
        var stmt: OpaquePointer?
        //the insert query
        let queryString = "INSERT INTO Workout (WorkoutName) VALUES ('\(workoutModel.WorkoutName)')"
        
        if sqlite3_exec(db, queryString, nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
    }
    func updateWorkout(workoutModel:WorkoutModel)
    {
        self.createWorkoutTable()
        let db = DBUtil().getConnectione()
        
        //creating a statement
        var stmt: OpaquePointer?
        //the update query
        let queryString = "UPDATE Workout SET WorkoutName = '\(workoutModel.WorkoutName)' WHERE WorkoutId = '\(workoutModel.WorkoutId)'"
        
        if sqlite3_exec(db, queryString, nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error updating table: \(errmsg)")
        }
    }
    func deleteWorkout(WorkoutId:Int32)
    {
        self.createWorkoutTable()
        let db = DBUtil().getConnectione()
        
        //creating a statement
        var stmt: OpaquePointer?
        //the delete query
        let queryString = "DELETE FROM Workout WHERE WorkoutId = '\(WorkoutId)'"
        
        if sqlite3_exec(db, queryString, nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
    }
    func getWorkoutNameList() -> [WorkoutModel]
    {
        let db = DBUtil().getConnectione()
        var WorkoutList = [WorkoutModel]()
        
        //statement pointer
        var stmt:OpaquePointer?
        let queryString = "SELECT * FROM Workout;"
        
        //preparing the query
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return WorkoutList
        }
        
        //traversing through all the records
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let WorkoutId = sqlite3_column_int(stmt, 0)
            let WorkoutName = String(cString: sqlite3_column_text(stmt, 1))
            
            //adding values to list
            WorkoutList.append(WorkoutModel.init(WorkoutId: WorkoutId, WorkoutName: WorkoutName))
        }
        
        return WorkoutList
    }
}
 
