//
//  LapModel.swift
//  workoutapp
//
//  Created by BSH on 2018. 3. 25..
//  Copyright © 2018년 hch_enterprise. All rights reserved.
//

import Foundation

class LapModel
{
    var seq: Int32
    var timeText: String
    
    init(seq:Int32, timeText: String)
    {
        self.seq = seq
        self.timeText = timeText
    }
}
