//
//  WorkoutItemTableViewCell.swift
//  workoutapp
//
//  Created by hyerim on 2018-04-08.
//  Copyright © 2018 hch_enterprise. All rights reserved.
//

import UIKit

class WorkoutItemTableViewCell: UITableViewCell {

    @IBOutlet weak var workoutItem: UITextField!
    var workoutItemIndexPath = IndexPath()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
