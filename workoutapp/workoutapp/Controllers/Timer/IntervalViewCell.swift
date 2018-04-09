//
//  IntervalViewCell.swift
//  workoutapp
//
//  Created by BSH on 2018. 4. 8..
//  Copyright © 2018년 hch_enterprise. All rights reserved.
//

import UIKit

class IntervalViewCell: UITableViewCell {

    @IBOutlet weak var CurrentIntervalLabel: UILabel!
    @IBOutlet weak var IntensityLabel: UILabel!
    @IBOutlet weak var TimerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
