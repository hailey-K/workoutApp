//
//  CalendarVars.swift
//  workoutapp
//
//  Created by Harmandeep Kaur on 2018-04-07.
//  Copyright © 2018 hch_enterprise. All rights reserved.
//

import UIKit

let date = Date()
let calendar = Calendar.current
let day = calendar.component(.day, from: date)
var weekday = calendar.component(.weekday, from: date)
var month = calendar.component(.month, from: date) - 1
var year = calendar.component(.year, from: date)
