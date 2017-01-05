//
//  PopViewController.swift
//  RunnningMan
//
//  Created by 刘立冬 on 2016/12/27.
//  Copyright © 2016年 刘立冬. All rights reserved.
//

import UIKit

class PopViewController: UIViewController{

    @IBOutlet var createActivityImageView:UIImageView!
    @IBOutlet var organizeActivityImageView:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        renderImageColor()
        let seperatorLine = myView.init(frame: CGRect(x:14,y:40,width:110,height:1))
        self.view.addSubview(seperatorLine)
        seperatorLine.draw(self.view.frame)
    }

    //修改显示图片颜色
    func renderImageColor(){
        createActivityImageView.image = createActivityImageView.image!.withRenderingMode(.alwaysTemplate)
        createActivityImageView.tintColor = UIColor(red: 208/255.0, green: 2/255.0, blue: 27/255.0, alpha: 1.0)
        organizeActivityImageView.image = organizeActivityImageView.image!.withRenderingMode(.alwaysTemplate)
        organizeActivityImageView.tintColor = UIColor(red: 208/255.0, green: 2/255.0, blue: 27/255.0, alpha: 1.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
