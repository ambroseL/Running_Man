//
//  UserSocialInfoDAO.swift
//  RunningMan
//
//  Created by orient on 2017/1/6.
//  Copyright © 2017年 刘立冬. All rights reserved.
//

import Foundation
import Alamofire.Swift


open class UserSocialInfoDAO: NSObject {
    
    open var delegate: UserSocialInfoDAODelegate!
    
    open static let sharedInstance: UserSocialInfoDAO = {
        let instance = UserSocialInfoDAO()
        return instance
    }()
    
    //插入Note方法
    open func create(_ model: UserSocialInfo) {
        
        let params = ["type": "JSON", "action": "add", "userID":model.userID,"userName":model.userName,"Sex":model.Sex,
                      "Signature":model.Signature,"likeNum":model.likeNum,"participatedActivitiesNum":model.participatedActivitiesNum,"organizedActivitiesNum":model.organizedActivitiesNum] as [String : Any]
        
        
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
    open func remove(_ model: UserSocialInfo) {
        
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
    open func modify(_ model: UserSocialInfo) {
        
        let params = ["type": "JSON", "action": "modify", "userID":model.userID,"userName":model.userName,"Sex":model.Sex,
                      "Signature":model.Signature,"likeNum":model.likeNum,"participatedActivitiesNum":model.participatedActivitiesNum,"organizedActivitiesNum":model.organizedActivitiesNum] as [String : Any]
        
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
    
    //查询所有数据方法
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
                            let usersocialinfo=UserSocialInfo()
        
                            let u_id = dic["userID"] as! NSNumber
                            usersocialinfo.userID=u_id.stringValue
                            usersocialinfo.userName=dic["userName"] as! String
                            usersocialinfo.Sex=dic["Sex"] as! String
                            usersocialinfo.Signature=dic["Signature"] as!String
                            let ln=dic["likeNum"] as!NSNumber
                            usersocialinfo.likeNum=ln.intValue
                            let pn=dic["participatedActicitiesNum"] as! NSNumber
                            usersocialinfo.participatedActivitiesNum=pn.intValue
                            let on=dic["organizedActivitiesNum"] as!NSNumber
                            usersocialinfo.organizedActivitiesNum=on.intValue
            
                            listData.add(usersocialinfo)
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
    
    //按照主键查询数据方法
    open func findById(_ model: UserSocialInfo) {
        
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
                        let usersocialinfo=UserSocialInfo()
                        
                        let u_id = dic["userID"] as! NSNumber
                        usersocialinfo.userID=u_id.stringValue
                        usersocialinfo.userName=dic["userName"] as! String
                        usersocialinfo.Sex=dic["Sex"] as! String
                        usersocialinfo.Signature=dic["Signature"] as!String
                        let ln=dic["likeNum"] as!NSNumber
                        usersocialinfo.likeNum=ln.intValue
                        let pn=dic["participatedActicitiesNum"] as! NSNumber
                        usersocialinfo.participatedActivitiesNum=pn.intValue
                        let on=dic["organizedActivitiesNum"] as!NSNumber
                        
                        usersocialinfo.organizedActivitiesNum=on.intValue
                        self.delegate.findByIdFinished?(usersocialinfo)
                        
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
