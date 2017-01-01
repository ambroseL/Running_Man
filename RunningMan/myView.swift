//
//  myView.swift
//  RunnningMan
//
//  Created by 刘立冬 on 2016/12/27.
//  Copyright © 2016年 刘立冬. All rights reserved.
//

import UIKit

class myView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    
    override func draw(_ rect: CGRect) {
        UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.8).setFill()
        UIRectFill(CGRect(x:0, y:0, width:self.frame.width, height:self.frame.height));
    }
}
