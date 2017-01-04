//
//  MapViewController.swift
//  RunningMan
//
//  Created by 刘立冬 on 2016/12/30.
//  Copyright © 2016年 刘立冬. All rights reserved.
//

import UIKit

class MapViewController: UIViewController,MAMapViewDelegate {
    
    var mapView: MAMapView!
    @IBOutlet var pauseContainerView:UIView!
    @IBOutlet var pauseView:UIView!
    @IBOutlet var mapBackgroundView:UIView!
    @IBOutlet var exerciseInfoContainerView:UIView!
    @IBOutlet var exerciseInfoView:UIView!
    @IBOutlet var pauseButton:UIButton!
    @IBOutlet var exitButton:UIButton!
    @IBOutlet var playButton:UIButton!
    
    @IBOutlet var speedLabel:UILabel!
    @IBOutlet var paceLabel:UILabel!
    @IBOutlet var timerLabel:UILabel!
    
    var timer:DispatchSourceTimer? = nil
    
    var percents:Int = 0;
    var seconds:Int = 0;
    var minutes:Int = 0;
    
    var isCounting:Bool = false
    
    var infoViewisUp:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pauseButton.changeBackgroundColor()
        pauseView.isHidden = true
        
        initLabelFont(label: timerLabel)
        initLabelFont(label: speedLabel)
        initLabelFont(label: paceLabel)
        
        initButton(button: exitButton, color: UIColor(red: 255/255.0, green: 147/255.0, blue: 36/255.0, alpha: 1.0).cgColor)
        
        initButton(button: playButton, color: UIColor(red: 234/255.0, green: 94/255.0, blue: 91/255.0, alpha: 1.0).cgColor)
        
        AMapServices.shared().apiKey = "2fcdc1d7039ff55b4b3e45367bcf9245"
    
        
        initBlurEffect()
        addBounds2InfoView()

        initMapView()
        initSwipeGesture()
        
    }
    
    func initTimer(){
        isCounting = true
        timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
        timer?.setEventHandler(handler: {
            // 返回主线程处理一些事件，更新UI等等
            DispatchQueue.main.async {
            self.startCounting()
            }
        })
        timer?.scheduleRepeating(deadline: .now(), interval: .milliseconds(10))
        timer?.resume()
    }
    
    func startCounting(){
        percents += 1
        if(percents == 100){
            seconds += 1
            percents = 0
        }
        if (seconds == 60) {
            minutes += 1
            seconds = 0;
        }
        timerLabel.text = String(format:"%02d:%02d:%02d",minutes,seconds,percents)
    }
    
    func initBlurEffect(){
        let blurEffect2Info = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView2Info = UIVisualEffectView(effect: blurEffect2Info)
        blurEffectView2Info.frame = exerciseInfoContainerView.bounds
        blurEffectView2Info.layer.cornerRadius = CGFloat(20.0)
        blurEffectView2Info.clipsToBounds = true
        
        exerciseInfoContainerView.addSubview(blurEffectView2Info)
        exerciseInfoContainerView.bringSubview(toFront: exerciseInfoView)
        
        let blurEffect2Pause = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView2Pause = UIVisualEffectView(effect: blurEffect2Pause)
        blurEffectView2Pause.frame = pauseContainerView.bounds
        pauseContainerView.addSubview(blurEffectView2Pause)
        pauseContainerView.bringSubview(toFront: pauseView)
        
        exerciseInfoContainerView.layer.cornerRadius = CGFloat(20.0)
        exerciseInfoContainerView.clipsToBounds = true
    }
    
    func addBounds2InfoView(){
        let seperatorLine = myView.init(frame: CGRect(x:150,y:5,width:exerciseInfoContainerView.frame.width - 300,height:5))
        exerciseInfoContainerView.addSubview(seperatorLine)
        seperatorLine.layer.cornerRadius = CGFloat(2.0)
        seperatorLine.clipsToBounds = true
    }
    
    func initButton(button:UIButton,color:CGColor){
        button.layer.cornerRadius = button.frame.width/2
        button.layer.borderWidth = 2
        button.layer.borderColor = color
    }
    
    func initLabelFont(label:UILabel){
        label.font = UIFont.monospacedDigitSystemFont(ofSize: CGFloat(24), weight: UIFontWeightSemibold)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        UIApplication.shared.statusBarStyle = .lightContent
        isCounting = false
        initTimer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mapView.isShowsUserLocation = true
        mapView.userTrackingMode = MAUserTrackingMode.follow
    }

    func initMapView() {
        mapView = MAMapView(frame: self.view.bounds)
        mapView.delegate = self
        self.mapBackgroundView.addSubview(mapView!)
        mapBackgroundView.bringSubview(toFront: pauseButton)
        mapBackgroundView.bringSubview(toFront: exerciseInfoContainerView)
    }
    
    @IBAction func pasueRunning(){
        if isCounting == true{
            self.timer?.suspend()
            isCounting = false
            pauseView.isHidden = false
            //View下移
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: { () -> Void in
                self.pauseContainerView.frame.origin.y += self.view.frame.height
            }, completion: nil)
        }
    }
    
    @IBAction func resumeRunning(){
        if isCounting == false{
             self.timer?.resume()
            isCounting = true
            //View上移
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: { () -> Void in
                self.pauseContainerView.frame.origin.y -= self.view.frame.height
            }, completion: nil)
            pauseView.isHidden = true
        }
        
    }
    
    func infoViewMoveUp(){
        if infoViewisUp == false {
            infoViewisUp = true
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: { () -> Void in
                self.exerciseInfoContainerView.frame.origin.y -= self.exerciseInfoContainerView.frame.height
            }, completion: nil)
            
        }
    }
    
    func infoViewMoveDown(){
        if infoViewisUp == true {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: { () -> Void in
                self.exerciseInfoContainerView.frame.origin.y += self.exerciseInfoContainerView.frame.height
            }, completion: nil)
            infoViewisUp = false
        }
    }
    
    func initSwipeGesture(){
        //初始化主视图的手势
        let swipe2Up = UISwipeGestureRecognizer()
        swipe2Up.direction = UISwipeGestureRecognizerDirection.up
        swipe2Up.addTarget(self, action: #selector(self.infoViewMoveUp))
        
        let swipe2Down = UISwipeGestureRecognizer()
        swipe2Down.direction = UISwipeGestureRecognizerDirection.down
        swipe2Down.addTarget(self, action: #selector(self.infoViewMoveDown))
        
        self.exerciseInfoContainerView.addGestureRecognizer(swipe2Up)
        self.exerciseInfoContainerView.addGestureRecognizer(swipe2Down)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Run2Record"{
            timer?.cancel()
            self.view.isHidden = true
        }
    }
    
}
