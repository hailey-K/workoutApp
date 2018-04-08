//
//  WorkoutItem.swift
//  workoutapp
//
//  Created by Hailey on 2018-04-07.
//  Copyright © 2018 hch_enterprise. All rights reserved.
//

import Foundation
 import SQLite3
class WorkoutItemDB
{
    private func createWorkoutItemTable()
    {
        let db = DBUtil().getConnectione()
        
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS WorkoutItem (WorkoutItemId INTEGER PRIMARY KEY AUTOINCREMENT, WorkoutItemName TEXT)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
        else
        {
            print("Create Success")
        }
    }
    
    func insertWorkoutItem(workoutItemModel:WorkoutItemModel)
    {
        self.createWorkoutItemTable()
        let db = DBUtil().getConnectione()
        
        //creating a statement
        var stmt: OpaquePointer?
        //the insert query
        let queryString = "INSERT INTO WorkoutItem (WorkoutItemName) VALUES ('\(workoutItemModel.WorkoutItemName)')"
        
        if sqlite3_exec(db, queryString, nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
    }
    func updateWorkoutItem(workoutItemModel:WorkoutItemModel)
    {
        self.createWorkoutItemTable()
        let db = DBUtil().getConnectione()
        
        //creating a statement
        var stmt: OpaquePointer?
        //the update query
        let queryString = "UPDATE WorkoutItem SET WorkoutItemName = '\(workoutItemModel.WorkoutItemName)' WHERE WorkoutItemId = '\(workoutItemModel.WorkoutItemId)'"
        
        if sqlite3_exec(db, queryString, nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error updating table: \(errmsg)")
        }
    }
    func deleteWorkoutItem(WorkoutItemId:Int32)
    {
        self.createWorkoutItemTable()
        let db = DBUtil().getConnectione()
        
        //creating a statement
        var stmt: OpaquePointer?
        //the delete query
        let queryString = "DELETE FROM WorkoutItem WHERE WorkoutItemId = '\(WorkoutItemId)'"
        
        if sqlite3_exec(db, queryString, nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
    }
    func getWorkoutItemNameList() -> [WorkoutItemModel]
    {
        let db = DBUtil().getConnectione()
        var WorkoutItemList = [WorkoutItemModel]()
        
        //statement pointer
        var stmt:OpaquePointer?
        let queryString = "SELECT * FROM WorkoutItem;"
        
        //preparing the query
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return WorkoutItemList
        }
        
        //traversing through all the records
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let workoutItemId = sqlite3_column_int(stmt, 0)
            let workoutItemName = String(cString: sqlite3_column_text(stmt, 1))
            
            //adding values to list
            WorkoutItemList.append(WorkoutItemModel.init(WorkoutItemId: workoutItemId, WorkoutItemName: workoutItemName))
        }
        
        return WorkoutItemList
    }
}
