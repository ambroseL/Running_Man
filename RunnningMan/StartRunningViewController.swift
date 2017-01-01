//
//  StratRunningViewController.swift
//  RunningMan
//
//  Created by 刘立冬 on 2016/12/30.
//  Copyright © 2016年 刘立冬. All rights reserved.
//

extension UIButton{
    func changeBackgroundColor(){
        let image:UIImage = self.currentBackgroundImage!.withRenderingMode(.alwaysTemplate)
        self.setBackgroundImage(image, for: .normal)
    }
    
}

import UIKit
import FLAnimatedImage

//import SwiftGifOrigin

class StartRunningViewController: UIViewController {

    @IBOutlet var startButton:UIButton!
    @IBOutlet var discoveryButton:UIButton!
    @IBOutlet var gifView: FLAnimatedImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        initButton(button: startButton)
        initButton(button: discoveryButton)
        UIApplication.shared.statusBarStyle = .lightContent
    if let path =  Bundle.main.path(forResource: "demo", ofType: "gif"){
            if let data = NSData(contentsOfFile: path) {
                let gif = FLAnimatedImage(animatedGIFData: data as Data!)
                gifView.animatedImage = gif
                gifView.frame = self.view.frame
                gifView.contentMode = .scaleAspectFill
                gifView.clipsToBounds = true
            }
        }
        
    }

    func initButton(button:UIButton){
        //button.layer.borderColor = UIColor(red: 234/255.0, green: 94/255.0, blue: 91/255.0, alpha: 1.0).cgColor
        //button.layer.borderWidth = CGFloat(2.0)
        button.clipsToBounds = true
        button.layer.cornerRadius = CGFloat(5.0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //将顶栏设为白色
        UIApplication.shared.statusBarStyle = .lightContent
        navigationController?.navigationBar.isHidden = true
    }

    
    @IBAction func startButtonPressed(){
        //做一些检查...
        //初始化地图页面
        //initMapView()
    }

    @IBAction func close(segue:UIStoryboardSegue) {
        
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
