//
//  NoteDB.swift
//  workoutapp
//
//  Created by Hyerim on 2018-04-15.
//  Copyright © 2018 hch_enterprise. All rights reserved.
//

import Foundation
import SQLite3

class NoteDB
{
    private func createNoteTable()
    {
    
        let db = DBUtil().getConnectione()
        
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Note (noteId INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, contents TEXT,date TEXT, mark INTEGER)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
        else
        {
            print("Create Success")
        }
    }
    
    func insertNote(noteModel:NoteModel)
    {
        self.createNoteTable()
        let db = DBUtil().getConnectione()
        
        //creating a statement
        var stmt: OpaquePointer?
        //the insert query
        let queryString = "INSERT INTO Note (title, contents,date, mark) VALUES ('\(noteModel.title)','\(noteModel.contents)','\(noteModel.date)',\(noteModel.mark))"
        
        if sqlite3_exec(db, queryString, nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
    }
    func updateNote(noteModel:NoteModel)
    {
        self.createNoteTable()
        let db = DBUtil().getConnectione()
        
        //creating a statement
        var stmt: OpaquePointer?
        //the update query
        let queryString = "UPDATE Note SET title = '\(noteModel.title)', contents = '\(noteModel.contents)', date = '\(noteModel.date)',mark = '\(noteModel.mark)'WHERE noteId = '\(noteModel.noteId)'"
        
        if sqlite3_exec(db, queryString, nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
    }
    func deleteNote(noteId:Int32)
    {
        self.createNoteTable()
        let db = DBUtil().getConnectione()
        
        //creating a statement
        var stmt: OpaquePointer?
        //the delete query
        let queryString = "DELETE FROM Note WHERE noteId = '\(noteId)'"
        
        if sqlite3_exec(db, queryString, nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
    }
    func getNoteList(date:String) -> [NoteModel]
    {
        let db = DBUtil().getConnectione()
        var noteList = [NoteModel]()
        
        //statement pointer
        var stmt:OpaquePointer?
        let queryString = "SELECT * FROM Note WHERE date = '\(date)';"
        
        //preparing the query
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return noteList
        }
        
        
        //traversing through all the records
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let noteId = sqlite3_column_int(stmt, 0)
            let title = String(cString: sqlite3_column_text(stmt, 1))
            let contents = String(cString: sqlite3_column_text(stmt, 2))
            let date = String(cString: sqlite3_column_text(stmt, 3))
            let mark = sqlite3_column_int(stmt, 4)
            
            //adding values to list
            noteList.append(NoteModel.init(noteId: noteId, title: title, contents: contents, date: date, mark: mark))
        }
        
        return noteList
    }
}
