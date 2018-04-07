//
//  TimerDB.swift
//  workoutapp
//
//  Created by Hailey on 2018-03-31.
//  Copyright © 2018 hch_enterprise. All rights reserved.
//

import Foundation
import SQLite3

class TimerDB
{
    private func createTimerTable()
    {
        let db = DBUtil().getConnectione()
        
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Timer (TimerId INTEGER PRIMARY KEY AUTOINCREMENT, TimerName TEXT, NumberOfSets INTEGER, HighInetensity TEXT, LowIntensity TEXT)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
        else
        {
            print("Create Success")
        }
    }
    
    func insertTimer(timerModel:TimerModel)
    {
        self.createTimerTable()
        let db = DBUtil().getConnectione()
        
        //creating a statement
        var stmt: OpaquePointer?
        //the insert query
        let queryString = "INSERT INTO Timer (TimerName, NumberOfSets, HighInetensity, LowIntensity) VALUES ('\(timerModel.TimerName)','\(timerModel.NumberOfSets)','\(timerModel.HighInetensity)','\(timerModel.LowIntensity)')"
        
        if sqlite3_exec(db, queryString, nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
    }
    func updateTimer(timerModel:TimerModel)
    {
        self.createTimerTable()
        let db = DBUtil().getConnectione()
        
        //creating a statement
        var stmt: OpaquePointer?
        //the update query
        let queryString = "UPDATE Timer SET TimerName = '\(timerModel.TimerName)', NumberOfSets = '\(timerModel.NumberOfSets)', HighInetensity = '\(timerModel.HighInetensity)', LowIntensity = '\(timerModel.LowIntensity)' WHERE TimerId = '\(timerModel.TimerId)'"
        
        if sqlite3_exec(db, queryString, nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
    }
    func deleteTimer(TimerId:Int32)
    {
        self.createTimerTable()
        let db = DBUtil().getConnectione()
        
        //creating a statement
        var stmt: OpaquePointer?
        //the delete query
        let queryString = "DELETE FROM Timer WHERE TimerId = '\(TimerId)'"
        
        if sqlite3_exec(db, queryString, nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
    }
    func getTimerNameList() -> [TimerModel]
    {
        let db = DBUtil().getConnectione()
        var TimerList = [TimerModel]()
        
        //statement pointer
        var stmt:OpaquePointer?
        let queryString = "SELECT * FROM Timer;"
        
        //preparing the query
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return TimerList
        }
        
        //traversing through all the records
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let TimerId = sqlite3_column_int(stmt, 0)
            let TimerName = String(cString: sqlite3_column_text(stmt, 1))
            let NumberOfSets = sqlite3_column_int(stmt, 2)
            let HighInetensity = String(cString: sqlite3_column_text(stmt, 3))
            let LowIntensity = String(cString: sqlite3_column_text(stmt, 4))
            
            //adding values to list
            TimerList.append(TimerModel.init(TimerId: TimerId, TimerName: TimerName, NumberOfSets: NumberOfSets, HighInetensity: HighInetensity, LowIntensity: LowIntensity))
            //heroList.append(Hero(id: Int(id), name: String(describing: name), powerRanking: Int(powerrank)))
        }
        
        return TimerList
    }
 
}
