//
//  HotActivitiesCell.swift
//  RunnningMan
//
//  Created by 刘立冬 on 2016/12/25.
//  Copyright © 2016年 刘立冬. All rights reserved.
//

import UIKit

class HotActivitiesCell: UITableViewCell {

    @IBOutlet var organizerName:UILabel!
    @IBOutlet var activitiesTitleLabel:UILabel!
    @IBOutlet var activitiesDescriptionLabel:UILabel!
    @IBOutlet var userProfileButton:UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
