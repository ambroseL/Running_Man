//
//  activitiesImageCell.swift
//  RunnningMan
//
//  Created by 刘立冬 on 2016/12/25.
//  Copyright © 2016年 刘立冬. All rights reserved.
//

import UIKit

class ActivitiesImageCell: UITableViewCell {

    @IBOutlet var imageScrollView:UIScrollView! = UIScrollView()
    @IBOutlet var pageControl:UIPageControl! = UIPageControl()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
