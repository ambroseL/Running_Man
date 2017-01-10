//
//  SignUpViewController.swift
//  RunnningMan
//
//  Created by 刘立冬 on 2016/12/22.
//  Copyright © 2016年 刘立冬. All rights reserved.
//

import UIKit


class IdentityValidationController: UIViewController {

    @IBOutlet var IDTextField: UITextField!
    @IBOutlet var keyTextField: UITextField!
    
    @IBOutlet var sendValidationButton:UIButton!
    @IBOutlet var affirmButton: UIButton!
    
     var timer:DispatchSourceTimer? = nil
    
    var isValidStudent:Bool = false
    var pickOption = ["同济大学"]
    
    var secondCount = 60
    var percentCount = 0
    //绘制底部线条
    func drawBottomeLine(sender: AnyObject)->Void{
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor(red: 240.0/255.0, green: 235.0/255.0, blue: 241.0/255.0, alpha: 1.0).cgColor
        border.frame = CGRect(x: 0, y: sender.frame.size.height - width, width:  sender.frame.size.width, height: sender.frame.size.height)
        border.borderWidth = width
        sender.layer.addSublayer(border)
        sender.layer.masksToBounds = true
    }
    
    
    func initTimer(){
        self.timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
        self.timer?.scheduleRepeating(deadline: .now(), interval: .milliseconds(10))
        // 设定时间源的触发事件 
        self.timer?.setEventHandler(handler: {
            // 每秒计时一次 
            self.percentCount += 1
            if self.percentCount == 100{
                self.secondCount -= 1
                self.percentCount = 0
            }
            // 时间到了取消时间源 
            if self.secondCount <= 0 {
                self.timer?.cancel()
                self.sendValidationButton.isEnabled = true
                self.sendValidationButton.setTitle("发送验证码", for: .normal)
            } // 返回主线程处理一些事件，更新UI等等
            DispatchQueue.main.async {
                self.updateCounting()
            }
        }) // 启动时间源
        self.timer?.resume()
    }

    
    func updateCounting(){
        sendValidationButton.setTitle(String(format:"%ds后发送",secondCount), for: .normal)
//        sendValidationButton.titleLabel?.text = String(format:"%ds后再次发送",timeCount)
        sendValidationButton.titleLabel?.adjustsFontSizeToFitWidth=true
    }
    
    func endEdit(){
        self.view.endEditing(true)
    }
    
    
    func initTapGesture(){
        let tap =  UITapGestureRecognizer(target:self, action:#selector(self.endEdit))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)

    }
    
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

    @IBAction func confirmInfo(sender: AnyObject) {
        if self.IDTextField.validateIDNumber(){
            if self.keyTextField.validatePassword() {
                isValidStudent = true
            }else{
                self.alert(message: "密码格式不合法")
            }
            }else {
                self.alert(message: "学号格式不合法")
            }
        
        print("ID: \(IDTextField.text)")
        print("Type: \(keyTextField.text)")
    }
    
    @IBAction func editingChanged(sender: AnyObject) {
        if IDTextField.notEmpty && keyTextField.notEmpty{
            self.affirmButton.enable()
        } else {
            self.affirmButton.disable()
        }
    }

    func initButton(){
        affirmButton.layer.cornerRadius = 5.0
        affirmButton.disable()
        sendValidationButton.setTitle("发送验证码", for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initButton()
        initTapGesture()

        drawBottomeLine(sender: IDTextField)
        drawBottomeLine(sender: keyTextField)
        drawBottomeLine(sender: sendValidationButton)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "fromValidate2SignIn"{
            return true
        }
        return isValidStudent
    }
   

    /*
     MARK: - Navigation

     In a storyboard-based application, you will often want to do a little preparation before navigation
    */
    //将用户的学号传递给下一个页面
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromValidate2SignUp" {
            let destinationController = segue.destination as!SignUpViewController
                destinationController.usrPhoneNumber = isValidStudent ? IDTextField.text! : ""
            }
    }


    @IBAction func sendValidationID(){
        //...
        sendValidationButton.isEnabled = false
        initTimer()
    }
    
}
