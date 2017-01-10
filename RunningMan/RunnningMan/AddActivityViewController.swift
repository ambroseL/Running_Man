//
//  AddActivityController.swift
//  RunnningMan
//
//  Created by 刘立冬 on 2016/12/28.
//  Copyright © 2016年 刘立冬. All rights reserved.
//

import UIKit


class AddActivityViewController: UITableViewController,UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet var activityNameTextField: UITextField!
    @IBOutlet var positionTextField: UITextField!
    @IBOutlet var contactWayTextField: UITextField!
    @IBOutlet var startDateTextField: UITextField!
    @IBOutlet var endDateTextField: UITextField!
    @IBOutlet var typeTextField: UITextField!
    @IBOutlet var memberNumThresholdField: UITextField!
    @IBOutlet var activityDescriptionText: UITextView!
    @IBOutlet var createActivityButton:UIBarButtonItem!
    
    @IBOutlet var memberLimitCell:UITableViewCell!
    
    var typePickerView:UIPickerView = UIPickerView()
    var memberNumPickerView:UIPickerView = UIPickerView()

    var typePickOption = ["一对一","多人行","社团"]
    var memberNumPickOption = ["3-5人","5人以上"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        initTouchGesture()
        initPickerView(textField: typeTextField,pickerView: typePickerView)
        initPickerView(textField: memberNumThresholdField,pickerView: memberNumPickerView)
        self.createActivityButton.isEnabled = false
        initTimeSetting()
        memberLimitCell.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func initTimeSetting(){
        let calendar = Calendar.current
        let beginDate:Date = Date()
        let endDate:Date = calendar.date(byAdding: .hour, value: 1, to: beginDate)!
        startDateTextField.placeholder = convertDate2String(date: beginDate)
        endDateTextField.placeholder = convertDate2String(date: endDate)
        
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

    //Set number of components in picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //Set number of rows in components
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == typePickerView{
            return typePickOption.count
        }else if pickerView == memberNumPickerView{
            return memberNumPickOption.count
        }
        return 0
    }
    
    //Set title for each row
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == typePickerView{
            return typePickOption[row]
        }else if pickerView == memberNumPickerView{
            return memberNumPickOption[row]
        }
        return nil
    }
    
    //Update textfield text when row is selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == typePickerView{
            if typePickOption[row] != "一对一"{
                memberLimitCell.isHidden = false
            }else {
                memberLimitCell.isHidden = true
            }
            typeTextField.text = typePickOption[row]
        }else if pickerView == memberNumPickerView{
            memberNumThresholdField.text =  memberNumPickOption[row]
        }
    }

    @IBAction func saveEdit(sender: AnyObject){
        //self.view.endEditing(true)
        //reviewTextInfo = reviewText.text
        //保存data到数据库
        //...
        print("Saving data to context ...")
        //reviewText.resignFirstResponder()
        self.endEdit()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelEdit(sender: AnyObject){
        //self.view.endEditing(true)
        //reviewText.resignFirstResponder()
        print("Cancel data to context ...")
        self.endEdit()
        dismiss(animated: true, completion: nil)
    }
    
    //设置section与header间的距离
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(20)
    }
    
    func initTableView(){
        tableView.separatorColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.8)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        //采用自适应布局
        tableView.estimatedRowHeight = 300.0
        tableView.rowHeight = UITableViewAutomaticDimension

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
    
    func closeButtonPressed()
    {
        if typeTextField.isFirstResponder{
            typeTextField.resignFirstResponder()
        }else if memberNumThresholdField.isFirstResponder{
            memberNumThresholdField.resignFirstResponder()
        }
        endEdit()
    }
    
    func undoButtonPressed()
    {
        if typeTextField.isFirstResponder{
            typeTextField.resignFirstResponder()
            typeTextField.text = ""
        }else if memberNumThresholdField.isFirstResponder{
            memberNumThresholdField.resignFirstResponder()
            memberNumThresholdField.text = ""
        }
        endEdit()
    }

    
    func initPickerView(textField: UITextField,pickerView:UIPickerView){
        pickerView.delegate = self
        textField.inputView = pickerView
        pickerView.backgroundColor = UIColor.white
        addToolbar2TextField(textField: textField)
    }
    
    func addToolbar2TextField(textField:UITextField){
        
        let numberToolbar = UIToolbar(frame: CGRect(x:0, y:0, width:self.view.frame.width, height:50.0))
        numberToolbar.barStyle = UIBarStyle.default
        numberToolbar.items = [
            UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.undoButtonPressed)),
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.closeButtonPressed))]
        numberToolbar.sizeToFit()
        numberToolbar.tintColor = UIColor(red: 235.0/255.0, green: 74.0/255.0, blue: 94.0/255.0, alpha: 1.0)
        textField.inputAccessoryView = numberToolbar
        
    }
    
    func initTimePickerView(textField: UITextField,datePickerView:UIDatePicker){
        
        datePickerView.datePickerMode = UIDatePickerMode.dateAndTime
        datePickerView.locale = Locale.init(identifier: "zh-CN")
        
        
        let calendar = Calendar.current
        let currentDate:Date = Date()
        datePickerView.minimumDate = currentDate
        datePickerView.maximumDate = calendar.date(byAdding: .month, value: 1, to: currentDate)
        
        //时间间隔15min
        datePickerView.minuteInterval = 15
        
        textField.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    func convertDate2String(date:Date) -> String{
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        dateFormatter.locale = Locale.init(identifier: "zh-CN")
        
        return dateFormatter.string(from: date)
    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        
        if startDateTextField.isFirstResponder{
            startDateTextField.text = convertDate2String(date:sender.date)
        }else if endDateTextField.isFirstResponder{
            endDateTextField.text = convertDate2String(date:sender.date)
        }
    }
    
    @IBAction func textFieldEditing(sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        initTimePickerView(textField: sender, datePickerView: datePickerView)
        addToolbar2TextField(textField: sender)
    }
    //仅当所有待填项均非空时发布按钮可用
    @IBAction func editingChanged(sender: AnyObject) {
        if activityNameTextField.notEmpty && positionTextField.notEmpty && contactWayTextField.notEmpty && startDateTextField.notEmpty && endDateTextField.notEmpty && typeTextField.notEmpty && typeTextField.notEmpty && memberNumThresholdField.notEmpty && activityDescriptionText.text != ""{
            self.createActivityButton.isEnabled = true
        } else {
            self.createActivityButton.isEnabled = false
        }
    }

    func checkInputValid(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, dd MMM yyyy hh:mm"
        let dateObj = dateFormatter.date(from: startDateTextField.text!)
        print((dateFormatter.string(from: dateObj!)))
    }
}
