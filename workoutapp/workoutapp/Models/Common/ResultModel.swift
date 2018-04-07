//
//  ResultModel.swift
//  workoutapp
//
//  Created by BSH on 2018. 3. 25..
//  Copyright © 2018년 hch_enterprise. All rights reserved.
//

import Foundation

class ResultModel
{
    var isSuccess: Bool
    var errorMsg: String?
    
    init(isSuccess: Bool, errorMsg: String?)
    {
        self.isSuccess = isSuccess
        self.errorMsg = errorMsg
    }
}
