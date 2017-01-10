//
//  UserKeyInfoDAO.swift
//  RunningMan
//
//  Created by orient on 2017/1/6.
//  Copyright © 2017年 刘立冬. All rights reserved.
//

import Foundation

import Alamofire.Swift

let WEBSERVICE_URL = ""

open class UserKeyInfoDAO: NSObject {
    
    open var delegate: UserKeyInfoDAODelegate!
    
    open static let sharedInstance: UserKeyInfoDAO = {
        let instance = UserKeyInfoDAO()
        return instance
    }()
    
    //插入Note方法
    open func create(_ model: UserKeyInfo) {
        
        let params = ["type": "JSON", "action": "add", "userID":model.userID,"userName":model.userName,"Pwd": model.Pwd,
                      "mailAddress":model.mailAddress,"studentID":model.studentID,"identityID":model.identityID,"Sex":model.Sex]
        
        
        Alamofire.request(WEBSERVICE_URL,method: .post , parameters: params)
            .responseJSON(completionHandler: {
                response in
                if let error = response.result.error {
                    self.delegate.createFailed?(error as NSError)
                } else {
                    
                    let resDict = response.result.value as! NSDictionary
                    let resultCodeNumber: NSNumber = resDict["ResultCode"] as! NSNumber
                    let resultCode = resultCodeNumber.intValue
                    
                    if resultCode >= 0 {
                        self.delegate.createFinished?()
                    } else {
                        let message = resultCodeNumber.errorMessage
                        let userInfo = [NSLocalizedDescriptionKey: message]
                        let err = NSError(domain: "DAO", code: resultCode, userInfo: userInfo)
                        
                        self.delegate.createFailed?(err)
                    }
                }
            })
    }
    
    //删除Note方法
    open func remove(_ model: UserKeyInfo) {
        
        let params = ["type": "JSON", "action": "remove", "userID":model.userID]
        
        Alamofire.request(WEBSERVICE_URL, method:.post,parameters: params)
            .responseJSON(completionHandler: {
                response in
                if let error = response.result.error {
                    self.delegate.removeFailed?(error as NSError)
                } else {
                    
                    let resDict = response.result.value as! NSDictionary
                    let resultCodeNumber: NSNumber = resDict["ResultCode"] as! NSNumber
                    let resultCode = resultCodeNumber.intValue
                    
                    if resultCode >= 0 {
                        self.delegate.removeFinished?()
                    } else {
                        let message = resultCodeNumber.errorMessage
                        let userInfo = [NSLocalizedDescriptionKey: message]
                        let err = NSError(domain: "DAO", code: resultCode, userInfo: userInfo)
                        
                        self.delegate.removeFailed?(err)
                    }
                }
            })
    }
    
    //修改Note方法
    open func modify(_ model: UserKeyInfo) {
        
        let params = ["type": "JSON", "action": "modify", "userID":model.userID,"userName":model.userName,"Pwd": model.Pwd,
                      "mailAddress":model.mailAddress,"studentID":model.studentID,"identityID":model.identityID,"Sex":model.Sex]
        
        Alamofire.request(WEBSERVICE_URL,method:.post, parameters: params)
            .responseJSON(completionHandler: {
                response in
                if let error = response.result.error {
                    self.delegate.modifyFailed?(error as NSError)
                } else {
                    
                    let resDict = response.result.value as! NSDictionary
                    let resultCodeNumber: NSNumber = resDict["ResultCode"] as! NSNumber
                    let resultCode = resultCodeNumber.intValue
                    
                    if resultCode >= 0 {
                        self.delegate.modifyFinished?()
                    } else {
                        let message = resultCodeNumber.errorMessage
                        let userInfo = [NSLocalizedDescriptionKey: message]
                        let err = NSError(domain: "DAO", code: resultCode, userInfo: userInfo)
                        
                        self.delegate.modifyFailed?(err)
                    }
                }
            })
    }
    open func findAll() {
        
        let params = ["type": "JSON", "action": "query"]
        
        Alamofire.request(WEBSERVICE_URL,method:.post, parameters: params)
            .responseJSON(completionHandler: {
                response in
                if let error = response.result.error {
                    self.delegate.findAllFailed?(error as NSError)
                } else {
                    
                    let resDict = response.result.value as! NSDictionary
                    let resultCodeNumber: NSNumber = resDict["ResultCode"] as! NSNumber
                    let resultCode = resultCodeNumber.intValue
                    
                    if resultCode >= 0 {
                        //从服务器返回数据
                        let listDict = resDict["Record"] as! NSMutableArray
                        
                        //准备返回给上层数据
                        let listData = NSMutableArray()
                        
                        for i in listDict {
                            let dic = listDict[i as! Int] as! NSDictionary
                            let userkeyinfo=UserKeyInfo()
                            let u_id = dic["userID"] as! NSNumber
                            userkeyinfo.userID = u_id.stringValue
                            userkeyinfo.userName = dic["userName"] as! String
                            userkeyinfo.mailAddress = dic["mailAddress"] as! String
                            userkeyinfo.Sex = dic["Sex"] as! String
                            let stu_id = dic["studentID"] as! NSNumber
                            userkeyinfo.studentID = stu_id.stringValue
                            
                            listData.add(userkeyinfo)
                        }
                        self.delegate.findAllFinished?(listData)
                        
                    } else {
                        let message = resultCodeNumber.errorMessage
                        let userInfo = [NSLocalizedDescriptionKey: message]
                        let err = NSError(domain: "DAO", code: resultCode, userInfo: userInfo)
                        
                        self.delegate.findAllFailed?(err)
                    }
                }
            })
    }
    //验证是否合法
    open func check(_ model:UserKeyInfo) {
        
        let params = ["type": "JSON", "action": "check", "userID":model.userID,"userName":model.userName,"Pwd": model.Pwd,
                      "mailAddress":model.mailAddress,"studentID":model.studentID,"identityID":model.identityID,"Sex":model.Sex]
        
        Alamofire.request(WEBSERVICE_URL,method:.post, parameters: params)
            .responseJSON(completionHandler: {
                response in
                if let error = response.result.error {
                    self.delegate.modifyFailed?(error as NSError)
                } else {
                    
                    let resDict = response.result.value as! NSDictionary
                    let resultCodeNumber: NSNumber = resDict["ResultCode"] as! NSNumber
                    let resultCode = resultCodeNumber.intValue
                    
                    if resultCode >= 0 {
                        self.delegate.checkFinished?()
                    } else {
                        let message = resultCodeNumber.errorMessage
                        let userInfo = [NSLocalizedDescriptionKey: message]
                        let err = NSError(domain: "DAO", code: resultCode, userInfo: userInfo)
                        
                        self.delegate.checkFailed?(err)
                    }
                }
            })
    }
    
    
    //按照主键查询数据方法
    open func findById(_ model: UserKeyInfo) {
        
        let params = ["type": "JSON", "action": "query", "userID":model.userID]
        
        Alamofire.request(WEBSERVICE_URL, method:.post, parameters: params)
            .responseJSON(completionHandler: {
                response in
                if let error = response.result.error {
                    self.delegate.findAllFailed?(error as NSError)
                } else {
                    
                    let resDict = response.result.value as! NSDictionary
                    let resultCodeNumber: NSNumber = resDict["ResultCode"] as! NSNumber
                    let resultCode = resultCodeNumber.intValue
                    
                    if resultCode >= 0 {
                        //从服务器返回数据
                        let listDict = resDict["Record"] as! NSMutableArray
                        
                        //准备返回给上层数据
                        let dic = listDict[0] as! NSDictionary
                        
                        let userkeyinfo=UserKeyInfo()
                        let u_id = dic["userID"] as! NSNumber
                        userkeyinfo.userID = u_id.stringValue
                        userkeyinfo.userName = dic["userName"] as! String
                        userkeyinfo.mailAddress = dic["mailAddress"] as! String
                        userkeyinfo.Sex = dic["Sex"] as! String
                        let stu_id = dic["studentID"] as! NSNumber
                        userkeyinfo.studentID = stu_id.stringValue
                        
                        self.delegate.findByIdFinished?(userkeyinfo)
                        
                    } else {
                        let message = resultCodeNumber.errorMessage
                        let userInfo = [NSLocalizedDescriptionKey: message]
                        let err = NSError(domain: "DAO", code: resultCode, userInfo: userInfo)
                        
                        self.delegate.findByIdFailed?(err)
                    }
                }
            })
    }
    
}
