//
//  MineOrganizedActivitiesCell.swift
//  RunnningMan
//
//  Created by 刘立冬 on 2016/12/25.
//  Copyright © 2016年 刘立冬. All rights reserved.
//

import UIKit

class MineOrganizedActivitiesCell: UITableViewCell {

    @IBOutlet var activityState:UILabel!
    @IBOutlet var activityDate:UILabel!
    @IBOutlet var activitiesTitleLabel:UILabel!
    @IBOutlet var activitiesDescriptionLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
