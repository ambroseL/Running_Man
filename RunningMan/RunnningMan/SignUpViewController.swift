//
//  SignUpsViewController.swift
//  RunnningMan
//
//  Created by 刘立冬 on 2016/12/23.
//  Copyright © 2016年 刘立冬. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var keyTextField: UITextField!
    @IBOutlet var phoneNumberTextField: UITextField!
    
    @IBOutlet var affirmButton: UIButton!
    
    var isValidInfo:Bool = false
    var usrID = ""
    
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
        if self.nameTextField.validateUserName(){
            if self.keyTextField.validatePassword() {
                if self.phoneNumberTextField.validatePhoneNumber(){
                    isValidInfo = true
                }else{
                    self.alert(message: "电话号码格式不合法")
                }
            }else{
                    self.alert(message: "密码格式不合法")
            }
        }
        else{
              self.alert(message: "昵称格式不合法")
        }

        
        print("name: \(nameTextField.text)")
        print("name: \(phoneNumberTextField.text)")
        print("Type: \(keyTextField.text)")
    }
    
    @IBAction func editingChanged(sender: AnyObject) {
        if nameTextField.notEmpty && keyTextField.notEmpty && phoneNumberTextField.notEmpty{
            self.affirmButton.enable()
        } else {
            self.affirmButton.disable()
        }
    }

    func initButton(){
        affirmButton.layer.cornerRadius = 5.0
        affirmButton.disable()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "fromSignUp2LogIn"{
            return true
        }else{
            return isValidInfo}
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
