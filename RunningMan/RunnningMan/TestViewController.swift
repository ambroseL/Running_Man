//
//  TestViewController.swift
//  RunningMan
//
//  Created by yoli on 06/01/2017.
//  Copyright © 2017 刘立冬. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet var textView:UITextView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let textview = UITextView(frame:CGRect(x:10, y:100, width:200, height:100))
        textview.layer.borderWidth = 1  //边框粗细
        textview.layer.borderColor = UIColor.gray.cgColor //边框颜色
        
       
        convertString()
        
        // Do any additional setup after loading the view.
    }
    
    func convertString(){
        
        var info:HealthInfo = HealthInfo.init()
        
        textView.text = "\(info.dailyClimbingStairsGoal)" + "hhhhh" + "\(info.weekWalkingStepsGoal)" + "qqqqq" + "\(info.dailyRunningDistanceGoal)"
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
