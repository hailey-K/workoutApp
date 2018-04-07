//
//  DBUtil.swift
//  workoutapp
//
//  Created by BSH on 2018. 3. 25..
//  Copyright © 2018년 hch_enterprise. All rights reserved.
//

import Foundation
import SQLite3

class DBUtil
{
    func getConnectione() -> OpaquePointer?
    {
        var db: OpaquePointer?
        //the database file
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("RIM.sqlite")
        //let fileURL = "/Users/BSH/Library/Developer/CoreSimulator/Devices";
        //opening the database
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        
        return db
    }
}
