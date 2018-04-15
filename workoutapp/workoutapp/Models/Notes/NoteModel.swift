//
//  NoteModel.swift
//  workoutapp
//
//  Created by Hyerim on 2018-04-15.
//  Copyright © 2018 hch_enterprise. All rights reserved.
//

import Foundation

class NoteModel
{
    var noteId: Int32
    var title: String
    var contents: String
    var mark : Int32 // true : 1, false : 0
    var date : String // format : month/date/year
    
    init(noteId:Int32, title: String, contents: String, date:String, mark: Int32)
    {
        self.noteId = noteId
        self.title = title
        self.contents = contents
        self.date = date
        self.mark = mark
    }
}
