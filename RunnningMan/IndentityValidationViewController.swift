//
//  SignUpViewController.swift
//  RunnningMan
//
//  Created by 刘立冬 on 2016/12/22.
//  Copyright © 2016年 刘立冬. All rights reserved.
//

import UIKit


class IdentityValidationController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {

    @IBOutlet var IDTextField: UITextField!
    @IBOutlet var keyTextField: UITextField!
    @IBOutlet var schoolTextField: UITextField!
    
    @IBOutlet var affirmButton: UIButton!
    
    var isValidStudent:Bool = false
    var pickOption = ["同济大学"]
    
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
    
    func closeButtonPressed()
    {
        schoolTextField.resignFirstResponder()
    }
    
    func undoButtonPressed()
    {
        schoolTextField.resignFirstResponder()
        schoolTextField.text = ""
    }
    
    func endEdit(){
        self.view.endEditing(true)
    }
    
    func initPickerView(){
        let pickerView = UIPickerView()
        
        pickerView.delegate = self
        
        schoolTextField.inputView = pickerView
        pickerView.backgroundColor = UIColor.white
        
        let toolBar = UIToolbar()
        toolBar.frame = CGRect(x:0, y:0, width:0, height:40)
        
        toolBar.barStyle = UIBarStyle.default
        toolBar.isOpaque = true
        toolBar.tintColor = UIColor(red: 235.0/255.0, green: 74.0/255.0, blue: 94.0/255.0, alpha: 1.0)
        
        let spaceBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
        
        spaceBarButton.width = 230
        
        let toolBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(self.undoButtonPressed))
        
        let closeButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.closeButtonPressed))
        
        toolBar.items = [toolBarButton, spaceBarButton, closeButton]
        
        schoolTextField.inputAccessoryView = toolBar
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
        if IDTextField.notEmpty && keyTextField.notEmpty && schoolTextField.notEmpty{
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

        initButton()
        initTapGesture()
        initPickerView()
        
        drawBottomeLine(textFiled: IDTextField)
        drawBottomeLine(textFiled: keyTextField)
        drawBottomeLine(textFiled: schoolTextField)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                destinationController.usrID = isValidStudent ? IDTextField.text! : ""
            }
    }


}
