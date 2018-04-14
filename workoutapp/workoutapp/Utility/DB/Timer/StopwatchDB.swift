//
//  StopwatchDB.swift
//  workoutapp
//
//  Created by hyerim on 2018. 3. 25..
//  Copyright © 2018년 hch_enterprise. All rights reserved.
//

import Foundation
import SQLite3

class StopwatchDB
{
    private func createLapsTable()
    {
        let db = DBUtil().getConnectione()
        
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Laps (seq INTEGER PRIMARY KEY AUTOINCREMENT, timeText TEXT)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
        else
        {
            print("Create Success")
        }
    }
    
    func insertALap(lapModel:LapModel)
    {
        self.createLapsTable()
        let db = DBUtil().getConnectione()
        
        //creating a statement
        var stmt: OpaquePointer?
        //the insert query
        let queryString = "INSERT INTO Laps (timeText) VALUES ('" + lapModel.timeText + "')"

        if sqlite3_exec(db, queryString, nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
        
        //readValues()
    }
    
    func getLapList() -> [LapModel]
    {
        let db = DBUtil().getConnectione()
        var LapList = [LapModel]()
        
        //statement pointer
        var stmt:OpaquePointer?
        let queryString = "SELECT * FROM Laps;"
        
        //preparing the query
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return LapList
        }
        
        //traversing through all the records
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let seq = sqlite3_column_int(stmt, 0)
            let timeText = String(cString: sqlite3_column_text(stmt, 1))
            
            //adding values to list
            LapList.append(LapModel.init(seq: seq, timeText: timeText))
            //heroList.append(Hero(id: Int(id), name: String(describing: name), powerRanking: Int(powerrank)))
        }
        
        return LapList
    }
}
