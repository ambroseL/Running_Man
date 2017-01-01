//
//  UserInfoTableViewCell.swift
//  RunnningMan
//
//  Created by 刘立冬 on 2016/12/24.
//  Copyright © 2016年 刘立冬. All rights reserved.
//

import UIKit

class UserInfoCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var orgnizedNumLabel: UILabel!
    @IBOutlet var participatedNumLabel: UILabel!
    @IBOutlet var likeInfoNumLabel: UILabel!
    @IBOutlet var uerInfoImageView: UIImageView!
    @IBOutlet var editSignatureButton: UIButton!
     @IBOutlet var signatureTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
