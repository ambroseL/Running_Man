//
//  ReviewTitleCell.swift
//  RunnningMan
//
//  Created by 刘立冬 on 2016/12/24.
//  Copyright © 2016年 刘立冬. All rights reserved.
//

import UIKit

class ReviewTitleCell: UITableViewCell {

    @IBOutlet var reviewTextLabel: UILabel!
    @IBOutlet var addReviewButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
