//
//  ViewController.swift
//  RunnningMan
//
//  Created by 刘立冬 on 2016/12/22.
//  Copyright © 2016年 刘立冬. All rights reserved.
//

import UIKit

extension UIButton{
    func disable() {
        self.isEnabled = false
        self.alpha = 0.5
    }
    func enable() {
        self.isEnabled = true
        self.alpha = 1
    }
}

extension UITextField {
    //检查内容非空
    var notEmpty: Bool{
        get {
            return self.text != ""
        }
    }
    
    //正则表达式使用基本方法
    func validate(RegEx: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", RegEx)
        return predicate.evaluate(with: self.text)
    }
    
    //检查邮箱输入是否合法
    func validateEmail() -> Bool {
        return self.validate(RegEx: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}")
    }
    
    //检查电话号码输入是否合法
    func validatePhoneNumber() -> Bool {
        return self.validate(RegEx: "^\\d{11}$")
    }
    
    //检查电话号码输入是否合法
    func validateIDNumber() -> Bool {
        return self.validate(RegEx: "^\\d{7,12}$")
    }
    
    //检查用户名输入是否合法
    func validateUserName()->Bool{
        return self.validate(RegEx: "^[A-Za-z0-9]{6,20}+$")
    }
    
    //检查密码是否合法
    func validatePassword() -> Bool {
        return self.validate(RegEx: "^[A-Z0-9a-z]{6,18}")
    }
}

class LogInViewController: UIViewController {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var keyTextField: UITextField!
    
    @IBOutlet var logInButton: UIButton!
    
    var isValidUser:Bool = false
    
    //绘制底部线条
    func drawBottomeLine(textFiled: UITextField)->Void{
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor(red: 240.0/255.0, green: 235.0/255.0, blue: 241.0/255.0, alpha: 1.0).cgColor
        border.frame = CGRect(x: 0, y: textFiled.frame.size.height - width, width:  textFiled.frame.size.width, height: textFiled.frame.size.height)
        border.borderWidth = width
        textFiled.layer.addSublayer(border)
        textFiled.layer.masksToBounds = true
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
    
    func initButton(){
        logInButton.layer.cornerRadius = 5.0
        logInButton.disable()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initButton()
        initTouchGesture()
        
        drawBottomeLine(textFiled: nameTextField)
        drawBottomeLine(textFiled: keyTextField)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    @IBAction func Login(sender: AnyObject) {
        if self.nameTextField.validateUserName() {
            if self.keyTextField.validatePassword() {
                //self.alert(message: "验证成功！")
                isValidUser = true
            }else {
                    self.alert(message: "密码格式不合法")
                }
            } else {
                self.alert(message: "用户名格式不合法")
        }
        
        print("Name: \(nameTextField.text)")
        print("Type: \(keyTextField.text)")
       
    }
    
    @IBAction func editingChanged(sender: AnyObject) {
        if nameTextField.notEmpty && keyTextField.notEmpty{
            self.logInButton.enable()
        } else {
            self.logInButton.disable()
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "fromLogIn2Validate"{
            return true
        }else{
            return isValidUser}
    }
}

