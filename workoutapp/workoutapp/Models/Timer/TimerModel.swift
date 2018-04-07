//
//  TimerModel.swift
//  workoutapp
//
//  Created by Hailey on 2018-03-31.
//  Copyright © 2018 hch_enterprise. All rights reserved.
//

import Foundation
class TimerModel
{
    var TimerId: Int32
    var TimerName: String
    var NumberOfSets: Int32
    var HighInetensity: String
    var LowIntensity: String

    init(TimerId:Int32, TimerName: String, NumberOfSets: Int32, HighInetensity: String, LowIntensity: String )
    {
        self.TimerId = TimerId
        self.TimerName = TimerName
        self.NumberOfSets = NumberOfSets
        self.HighInetensity = HighInetensity
        self.LowIntensity = LowIntensity
    }
}
