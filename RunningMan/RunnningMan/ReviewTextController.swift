//
//  ReviewTextController.swift
//  RunnningMan
//
//  Created by 刘立冬 on 2016/12/25.
//  Copyright © 2016年 刘立冬. All rights reserved.
//

import UIKit

class ReviewTextController: UIViewController {

    @IBOutlet var reviewText:UITextView!
    
    var reviewTextInfo: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewText.text = reviewTextInfo
        reviewText.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveEdit(sender: AnyObject){
        self.view.endEditing(true)
        reviewTextInfo = reviewText.text
        //保存data到数据库
        //...
        print("Saving data to context ...")
        reviewText.resignFirstResponder()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelEdit(sender: AnyObject){
        self.view.endEditing(true)
        reviewText.resignFirstResponder()
        print("Cancel data to context ...")
        dismiss(animated: true, completion: nil)
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
