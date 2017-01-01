//
//  HealthViewController.swift
//  RunningMan
//
//  Created by 刘立冬 on 2016/12/29.
//  Copyright © 2016年 刘立冬. All rights reserved.
//

import UIKit
import UICircularProgressRing


//特别注意，设置的数据应在用户离开界面时上传or放在本地，在某固定时段上传服务器

public extension UIImage {
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}

class HealthViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet var segmentControl:UISegmentedControl!
    @IBOutlet var segmentBackgroundView:UIView!
    var hairLine: UIView = UIView()
    
    @IBOutlet var runningDistanceLabel:UILabel!
    @IBOutlet var climbingStairsLabel:UILabel!
    @IBOutlet var walkingStepsLabel:UILabel!
    
    @IBOutlet var runningDistanceGoallField:UITextField!
    @IBOutlet var climbingStairsGoallField:UITextField!
    @IBOutlet var walkingStepsGoallField:UITextField!
    
    @IBOutlet var runningDistanceCircle: UICircularProgressRingView!
    @IBOutlet var climbingStairsCircle: UICircularProgressRingView!
    @IBOutlet var walkingStepsCircle: UICircularProgressRingView!
    
    
    //时段类型
    enum dataType:Int {
        case DAILY = 0
        case WEEK = 1
        case MONTH = 2
    }
    //记录当前显示的时段
    var presentType:dataType = .DAILY
    
    //二维数组装载数据
    var excerciseData:Array<Array<Float>> = [[],[],[]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "健康记录"
        removeHariLine()
        loadData()
        initData()
        initTouchGesture()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    //初始化数据，时段默认为当天
    func initData(){
        let index:Int = dataType.DAILY.rawValue
        //maxvalue初始化后不再改变
        runningDistanceCircle.maxValue = CGFloat(excerciseData[index][1])
        walkingStepsCircle.maxValue = CGFloat(excerciseData[index][3])
        climbingStairsCircle.maxValue = CGFloat(excerciseData[index][5])
        
        runningDistanceCircle.value = CGFloat(excerciseData[index][0])
        walkingStepsCircle.value = CGFloat(excerciseData[index][2])
        climbingStairsCircle.value = CGFloat(excerciseData[index][4])
        
        runningDistanceLabel.adjustsFontSizeToFitWidth = true
        climbingStairsLabel.adjustsFontSizeToFitWidth = true
        walkingStepsLabel.adjustsFontSizeToFitWidth = true
        runningDistanceGoallField.adjustsFontSizeToFitWidth = true
        walkingStepsGoallField.adjustsFontSizeToFitWidth = true
        climbingStairsGoallField.adjustsFontSizeToFitWidth = true
        
        updateLableData(index: index)
    }

    func updateLableData(index:Int){
        //设置显示值
        runningDistanceLabel.text = String(format:"%.1f",excerciseData[index][0])
        walkingStepsLabel.text = String(format:"%.0f",excerciseData[index][2])
        climbingStairsLabel.text = String(format:"%.0f",excerciseData[index][4])
        
        //设置目标显示
        runningDistanceGoallField.text = String(format:"%.1f",excerciseData[index][1])
        walkingStepsGoallField.text = String(format:"%.0f",excerciseData[index][3])
        climbingStairsGoallField.text = String(format:"%.0f",excerciseData[index][5])
    }
    
    func updateData(type:dataType){
        
        //分别填入跑步，步行，爬楼的实际和目标数据
        //设置轮子
        if(type == presentType){
            return
        }
        presentType = type
        var ratio:CGFloat = 1.0
        var value:CGFloat = 0.0
        let index:Int = presentType.rawValue
        
        ratio = CGFloat(Float(excerciseData[index][1])).divided(by: self.runningDistanceCircle.maxValue)
        value = CGFloat(excerciseData[index][0]).divided(by: CGFloat(ratio))
        updateDistanceCircle(value: value)
    
        ratio = CGFloat(Float(excerciseData[index][3])).divided(by: self.walkingStepsCircle.maxValue)
        value = CGFloat(excerciseData[index][2]).divided(by: CGFloat(ratio))
        updateStepsCircle(value:value)
        
        ratio = CGFloat(Float(excerciseData[index][5])).divided(by: self.climbingStairsCircle.maxValue)
        value = CGFloat(excerciseData[index][4]).divided(by: CGFloat(ratio))
        updateStairsCircle(value:value)
        
        updateLableData(index: index)
    }
    
    
    //仅在初始化页面时加载所有数据
    func loadData(){
        //根据选择不同获取对应时间的数据
        //分别载入跑步，步行，爬楼的实际和目标数据
        self.excerciseData[dataType.DAILY.rawValue] = [0.2, 0.3, 2000.0, 10000.0, 10.0, 20.0]
        self.excerciseData[dataType.WEEK.rawValue] = [12.0, 30.0, 50000.0, 60000.0, 40.0,120.0]
        self.excerciseData[dataType.MONTH.rawValue] = [48.0, 70.0, 200000.0, 300000.0, 280.0,480.0]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateDistanceCircle(value:CGFloat){
         self.runningDistanceCircle.setProgress(value: value, animationDuration: 2.0)
    }
    
    func updateStepsCircle(value:CGFloat){
        self.walkingStepsCircle.setProgress(value: value, animationDuration: 2.0)

    }
    
    func updateStairsCircle(value:CGFloat){
         self.climbingStairsCircle.setProgress(value: value, animationDuration: 2.0)
    }
    
    
    @IBAction func editingDistanceChanged(sender:AnyObject){
        let value:Float = Float(runningDistanceGoallField.text!)!
        if value <= excerciseData[presentType.rawValue][0]{
            if value < excerciseData[presentType.rawValue][0]{
                alert(message: "目标值应大于实际运动量，不要偷懒哦！")
                runningDistanceGoallField.text! = String(format:"%.1f",excerciseData[presentType.rawValue][1])
            }
            return
        }
        let ratio:CGFloat = CGFloat(value).divided(by: self.runningDistanceCircle.maxValue)
        excerciseData[presentType.rawValue][1] = Float(value)
        runningDistanceGoallField.text! = String(format:"%.1f",excerciseData[presentType.rawValue][1])
        updateDistanceCircle(value: CGFloat(excerciseData[presentType.rawValue][0]).divided(by: CGFloat(ratio)))
    }
    
    @IBAction func editingStepsChanged(sender:AnyObject){
        let value:Float = Float(walkingStepsGoallField.text!)!
        if value <= excerciseData[presentType.rawValue][2]{
            if value < excerciseData[presentType.rawValue][2]{
                alert(message: "目标值应大于实际运动量，不要偷懒哦！")
                walkingStepsGoallField.text! = String(format:"%.0f",excerciseData[presentType.rawValue][3])
            }
            return
        }
        let ratio:CGFloat = CGFloat(value).divided(by: self.walkingStepsCircle.maxValue)
        excerciseData[presentType.rawValue][3] = Float(value)
        updateStepsCircle(value: CGFloat(excerciseData[presentType.rawValue][2]).divided(by: CGFloat(ratio)))
    }
    
    @IBAction func editingStairsChanged(sender:AnyObject){
        let value:Float = Float(climbingStairsGoallField.text!)!
        if value <= excerciseData[presentType.rawValue][4]{
            if value < excerciseData[presentType.rawValue][4]
            {
                alert(message: "目标值应大于实际运动量，不要偷懒哦！")
                climbingStairsGoallField.text! = String(format:"%.0f",excerciseData[presentType.rawValue][5])
            }
            return
        }
        let ratio:CGFloat = CGFloat(value).divided(by: self.climbingStairsCircle.maxValue)
        excerciseData[presentType.rawValue][5] = Float(value)
        updateStairsCircle(value: CGFloat(excerciseData[presentType.rawValue][4]).divided(by: CGFloat(ratio)))
    }
    
    func removeHariLine(){
        segmentBackgroundView.backgroundColor = UIColor.init(patternImage: UIImage.init(color: UIColor(red: 208/255.0, green: 2/255.0, blue: 27/255.0, alpha: 1.0))!)
        navigationController?.navigationBar.setBackgroundImage(UIImage.init(color: UIColor(red: 208/255.0, green: 2/255.0, blue: 27/255.0, alpha: 1.0)), for: .default)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage.init(color: UIColor(red: 208/255.0, green: 2/255.0, blue: 27/255.0, alpha: 1.0))
    }
    
    //生成定时提示消息
    func alert(message: String) {
        let alc = UIAlertController(title: message, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alc.view.tintColor = UIColor.gray
        present(alc, animated: true, completion: nil)
        
        //设置定时器，间隔1s
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when) {
            alc.dismiss(animated: false, completion: nil)
        }
    }
    
    //点击屏幕空白处时停止编辑
    func endEdit(){
        self.view.endEditing(true)
    }
    
    //初始化点击手势
    func initTouchGesture(){
        let tap =  UITapGestureRecognizer(target:self, action:#selector(self.endEdit))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
    }
    
    @IBAction func changeTimeValue(sender:UISegmentedControl){
        if sender.selectedSegmentIndex == 0{
            updateData(type: .DAILY)
            presentType = .DAILY
        }else if sender.selectedSegmentIndex == 1{
            updateData(type: .WEEK)
            presentType = .WEEK
        }else{
            updateData(type: .MONTH)
            presentType = .MONTH
        }
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            self.view.frame.origin.y -= keyboardSize.height
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            self.view.frame.origin.y += keyboardSize.height
        }
    }
    
}
