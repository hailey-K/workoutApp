//
//  TimerViewCell.swift
//  workoutapp
//
//  Created by hyerim on 2018-04-01.
//  Copyright © 2018 hch_enterprise. All rights reserved.
//

import UIKit

class TimerViewCell: UITableViewCell {

    @IBOutlet weak var detailBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    var timerIndexPath = IndexPath()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func clickDetailBtn(_ sender: Any) {
        //self.setSelected(true, animated: true)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
