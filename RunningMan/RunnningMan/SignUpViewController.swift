//
//  SignUpsViewController.swift
//  RunnningMan
//
//  Created by 刘立冬 on 2016/12/23.
//  Copyright © 2016年 刘立冬. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var keyTextField: UITextField!
    @IBOutlet var schoolTextField: UITextField!
    @IBOutlet var schoolIDTextField: UITextField!
    
    @IBOutlet var affirmButton: UIButton!
    
    var pickOption = ["同济大学"]
    
    var isValidInfo:Bool = false
    var usrPhoneNumber = ""
    
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
                if self.schoolIDTextField.validateIDNumber(){
                    isValidInfo = true
                }else{
                    self.alert(message: "学号格式不合法")
                }
            }else{
                    self.alert(message: "密码格式不合法")
            }
        }
        else{
              self.alert(message: "昵称格式不合法")
        }

        
        print("name: \(nameTextField.text)")
        print("Type: \(keyTextField.text)")
    }
    
    @IBAction func editingChanged(sender: AnyObject) {
        if nameTextField.notEmpty && keyTextField.notEmpty && schoolTextField.notEmpty && schoolIDTextField.notEmpty{
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
    
    func initPickerView(){
        let pickerView = UIPickerView()
        
        pickerView.delegate = self
        
        schoolTextField.inputView = pickerView
        pickerView.backgroundColor = UIColor.white
        
        let numberToolbar = UIToolbar(frame: CGRect(x:0, y:0, width:self.view.frame.width, height:50.0))
        numberToolbar.barStyle = UIBarStyle.default
        numberToolbar.items = [
            UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.undoButtonPressed)),
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.closeButtonPressed))]
        numberToolbar.sizeToFit()
        numberToolbar.tintColor = UIColor(red: 235.0/255.0, green: 74.0/255.0, blue: 94.0/255.0, alpha: 1.0)
        schoolTextField.inputAccessoryView = numberToolbar
    }

    
    //Set number of components in picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //Set number of rows in components
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickOption.count
    }
    
    //Set title for each row
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickOption[row]
    }
    
    //Update textfield text when row is selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        schoolTextField.text = pickOption[row]
    }

    
    func closeButtonPressed()
    {
        schoolTextField.resignFirstResponder()
    }
    
    func undoButtonPressed()
    {
        schoolTextField.resignFirstResponder()
        schoolTextField.text = ""
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
