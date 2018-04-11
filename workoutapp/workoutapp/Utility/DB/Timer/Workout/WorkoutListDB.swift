//
//  WorkoutList.swift
//  workoutapp
//
//  Created by hyerim on 2018-04-10.
//  Copyright © 2018 hch_enterprise. All rights reserved.
//

import Foundation
import SQLite3
class WorkoutListDB
{
private func createWorkoutListTable()
{
    let db = DBUtil().getConnectione()
    
    if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS WorkoutList (WorkoutListId INTEGER PRIMARY KEY AUTOINCREMENT, WorkoutItemId INTEGER, WorkoutId)", nil, nil, nil) != SQLITE_OK {
        let errmsg = String(cString: sqlite3_errmsg(db)!)
        print("error creating table: \(errmsg)")
    }
    else
    {
        print("Create Success")
    }
}

func insertWorkoutList(workoutListModel:WorkoutListModel)
{
    self.createWorkoutListTable()
    let db = DBUtil().getConnectione()
    
    //creating a statement
    var stmt: OpaquePointer?
    //the insert query
    let queryString = "INSERT INTO WorkoutList (WorkoutItemId,WorkoutId) VALUES ('\(workoutListModel.WorkoutItemId,workoutListModel.workoutId)')"
    
    if sqlite3_exec(db, queryString, nil, nil, nil) != SQLITE_OK {
        let errmsg = String(cString: sqlite3_errmsg(db)!)
        print("error creating table: \(errmsg)")
    }
}
func updateWorkoutList(workoutListModel:WorkoutListModel)
{
    self.createWorkoutListTable()
    let db = DBUtil().getConnectione()
    
    //creating a statement
    var stmt: OpaquePointer?
    //the update query
    let queryString = "UPDATE WorkoutList SET WorkoutItemId = '\(workoutListModel.WorkoutItemId)', WorkoutId = '\(workoutListModel.workoutId)' WHERE WorkoutListId = '\(workoutListModel.WorkoutListId)'"
    
    if sqlite3_exec(db, queryString, nil, nil, nil) != SQLITE_OK {
        let errmsg = String(cString: sqlite3_errmsg(db)!)
        print("error updating table: \(errmsg)")
    }
}
func deleteWorkoutList(WorkoutListId:Int32)
{
    self.createWorkoutListTable()
    let db = DBUtil().getConnectione()
    
    //creating a statement
    var stmt: OpaquePointer?
    //the delete query
    let queryString = "DELETE FROM WorkoutList WHERE WorkoutListId = '\(WorkoutListId)'"
    
    if sqlite3_exec(db, queryString, nil, nil, nil) != SQLITE_OK {
        let errmsg = String(cString: sqlite3_errmsg(db)!)
        print("error creating table: \(errmsg)")
    }
}
    func getWorkoutListNameList(WorkoutId:Int32) -> [WorkoutListModel]
{
    let db = DBUtil().getConnectione()
    var WorkoutItemList = [WorkoutListModel]()
    
    //statement pointer
    var stmt:OpaquePointer?
    let queryString = "SELECT * FROM WorkoutList where WorkoutId='\(WorkoutId)';"
    
    //preparing the query
    if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
        let errmsg = String(cString: sqlite3_errmsg(db)!)
        print("error preparing insert: \(errmsg)")
        return WorkoutItemList
    }
    
    //traversing through all the records
    while(sqlite3_step(stmt) == SQLITE_ROW){
        let workoutListId = sqlite3_column_int(stmt, 0)
        let workoutItemId = sqlite3_column_int(stmt, 1)
        let workoutId = sqlite3_column_int(stmt, 2)
        
        //adding values to list
        WorkoutItemList.append(WorkoutListModel.init(WorkoutListId:workoutItemId, WorkoutItemId: workoutItemId,workoutId:workoutId))
    }
    
    return WorkoutItemList
}
}
