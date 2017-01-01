//
//  DEtailedActivitiesViewController.swift
//  RunnningMan
//
//  Created by 刘立冬 on 2016/12/26.
//  Copyright © 2016年 刘立冬. All rights reserved.
//

import UIKit

class DetailedActivitiesViewController: UITableViewController {

    var identifiersForEachSection = [["Title"],["UserInfo","ActivityDescription"]]
    
    var actityTile:String! = "今晚8:00和阿杜一起来夜跑吧！"
    var userName: String! = "阿杜"
    var userSignature:String! = "跑步，debug不如跑步"
    var userButtonImageUrl:String! = "Boy"
    
    //活动信息
    var startTimeStr: String! = "16/12/16 周日 18:00\n"
    var endTimeStr:String! = "16/12/16 周日 21:00\n"
    var placeStr:String! = "F楼\n"
    var memberNumThreshold:String! = "25人\n"
    var contactWayStr:String! = "QQ123456\n"
    var activityTypeStr: String! = "社团\n"
    var detailedDescriptionStr:String! = "为了让大家更好地锻炼身体，阿杜决定今晚带一波跑步节奏🏃"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "活动详情"
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorColor = UIColor.lightGray
        tableView.tableFooterView = UIView(frame: CGRect.zero)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return section == 0 ? 1:2

    }
    
    func setTitleCell(titleCell: DetailedActivityTitleCell){
        titleCell.activityTitleLable.text = actityTile
    }
    
    
    func setUserInfoCell(userInfoCell:DetailedActivityUserInfoCell){
        userInfoCell.userNameLabel.text = userName
        userInfoCell.userProfileButton.imageView?.image = UIImage(named:userButtonImageUrl)
        userInfoCell.userSignature.text = userSignature
        
        userInfoCell.joinActivityButton.layer.cornerRadius = 3;
        userInfoCell.joinActivityButton.layer.borderColor = UIColor.red.cgColor
        userInfoCell.joinActivityButton.layer.borderWidth = CGFloat(1)
        userInfoCell.joinActivityButton.setTitle("+ 参加活动", for: UIControlState.normal)
        userInfoCell.joinActivityButton.titleLabel?.font = UIFont(name: "Pingfang-SC-Semibold", size: 12)!
        userInfoCell.joinActivityButton.contentEdgeInsets = UIEdgeInsetsMake(5,5,5,5);
        
        //userInfoCell.frame.size = CGSize(width:10,height:10)
    }
    
    //处理待加粗的提示字体
    func appendTitleStr2AttributeStr(attributeStr: NSMutableAttributedString, appendStr: String){
        let tempAtrributeString: NSMutableAttributedString = NSMutableAttributedString(string:appendStr)
        tempAtrributeString.addAttribute(NSFontAttributeName, value: UIFont(name: "HelveticaNeue-Bold", size: 16)!,range: NSMakeRange(0,tempAtrributeString.length))
        attributeStr.insert(tempAtrributeString, at: attributeStr.length)
    }
    
    func appendStr2AttributeStr(attributeStr: NSMutableAttributedString, appendStr: String){
        let tempAtrributeString: NSMutableAttributedString = NSMutableAttributedString(string:appendStr)
        attributeStr.insert(tempAtrributeString, at: attributeStr.length)
    }
    
    func setAttributeStrParagraphStyle(attributeStr: NSMutableAttributedString){
        let style: NSMutableParagraphStyle = NSMutableParagraphStyle()
        style.lineSpacing = 10;//增加行高
        style.headIndent = 5;//头部缩进，相当于左padding
        style.tailIndent = -5;//相当于右padding
        style.lineHeightMultiple = 1.5;//行间距是多少倍
        style.alignment = NSTextAlignment.left;//对齐方式
        style.firstLineHeadIndent = 5;//首行头缩进
        style.paragraphSpacing = 10;//段落后面的间距
        style.paragraphSpacingBefore = 20;//段落之前的间距
        attributeStr.addAttribute(NSParagraphStyleAttributeName, value: style,range: NSMakeRange(0,attributeStr.length))
    }
    
    func setActivityInfoCell(activityInfoCell:DetailedActivityInfoCell){
        
        //富文本设置
        var NSStr:String = "开始时间："
        let attributeString = NSMutableAttributedString(string:NSStr)
        //HelveticaNeue-Bold,16号字体大小
        attributeString.addAttribute(NSFontAttributeName, value: UIFont(name: "HelveticaNeue-Bold", size: 16)!,range: NSMakeRange(0,NSStr.characters.count))
        
        //加载开始时间
        appendStr2AttributeStr(attributeStr: attributeString, appendStr: startTimeStr)
        
        //加载结束时间
        appendTitleStr2AttributeStr(attributeStr: attributeString, appendStr: "结束时间：")
        appendStr2AttributeStr(attributeStr: attributeString, appendStr: endTimeStr)

        //加载活动地点
        appendTitleStr2AttributeStr(attributeStr: attributeString, appendStr: "活动地点：")
        appendStr2AttributeStr(attributeStr: attributeString, appendStr: placeStr)


        //加载人数上限
        appendTitleStr2AttributeStr(attributeStr: attributeString, appendStr: "人数上限：")
        appendStr2AttributeStr(attributeStr: attributeString, appendStr: memberNumThreshold)

        
        //加载联系方式
        appendTitleStr2AttributeStr(attributeStr: attributeString, appendStr: "联系方式：")
        appendStr2AttributeStr(attributeStr: attributeString, appendStr: contactWayStr)

        
        //加载活动描述
        appendTitleStr2AttributeStr(attributeStr: attributeString, appendStr: "活动描述：")
        appendStr2AttributeStr(attributeStr: attributeString, appendStr: detailedDescriptionStr)

        
//        //设置字体颜色
//        attributeString.addAttribute(NSForegroundColorAttributeName, value: UIColor.blue,range: NSMakeRange(0, 3))
        
        
        
//        //设置文字背景颜色
//        attributeString.addAttribute(NSBackgroundColorAttributeName, value: UIColor.gray,range: NSMakeRange(3,3))
//        
//         activityInfoCell.activityInfoText.attributedText = attributeString
        
        setAttributeStrParagraphStyle(attributeStr: attributeString)
        activityInfoCell.activityInfoText.attributedText = attributeString
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = identifiersForEachSection[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        switch cellIdentifier{
        case "Title":
            setTitleCell(titleCell: cell as!DetailedActivityTitleCell)
            break
        case "UserInfo":
            setUserInfoCell(userInfoCell: cell as!DetailedActivityUserInfoCell)
            break
        case "ActivityDescription":
            setActivityInfoCell(activityInfoCell: cell as! DetailedActivityInfoCell)
            break
        default:
            break
        }
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
    }
  
    //设置section与header间的距离
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(0.01)
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
    
    @IBAction func joinActivity(){
        //无人数限制or
        alert(message:"约跑成功！")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Activity2User" {
            let destinationController = segue.destination as!MainPageViewController
            destinationController.isMine = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        UIApplication.shared.statusBarStyle = .lightContent
        // Remove the title of the back button
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.backItem?.title = ""
    }

}
