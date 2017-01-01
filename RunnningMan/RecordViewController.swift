//
//  RecordViewController.swift
//  RunningMan
//
//  Created by 刘立冬 on 2016/12/30.
//  Copyright © 2016年 刘立冬. All rights reserved.
//

import UIKit

class RecordViewController: UIViewController {

    @IBOutlet var timeLabel:UILabel!
    @IBOutlet var speedLabel:UILabel!
    @IBOutlet var distanceLabel:UILabel!
    
    @IBOutlet var timeView:UIView!
    @IBOutlet var speedView:UIView!
    @IBOutlet var distanceView:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        navigationController?.navigationBar.isHidden = false
        self.navigationItem.hidesBackButton = true
        
        initView(backgroundView: timeView)
        initView(backgroundView: speedView)
        initView(backgroundView: distanceView)
    }
    
    func initView(backgroundView:UIView){
        
        
        backgroundView.layer.cornerRadius = CGFloat(5.0)
        backgroundView.clipsToBounds = true
        
        let theView:UIView = UIView.init(frame: CGRect(x:0,y:0,width:backgroundView.frame.width,height:backgroundView.frame.height))
        
        backgroundView.addSubview(theView)
        backgroundView.sendSubview(toBack: theView)
        let gradientLayer:CAGradientLayer = CAGradientLayer()
        
        gradientLayer.frame = CGRect(x:0,y:0,width:backgroundView.frame.width,height:backgroundView.frame.height)
        
        //设置颜色数组
        gradientLayer.colors = [UIColor(red:232/255.0,green:118/255.0,blue:115/255.0,alpha: 1.0).cgColor,UIColor(red:244/255.0,green:18/255.0,blue:2/255.0,alpha: 1.0).cgColor]
        theView.layer.addSublayer(gradientLayer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
