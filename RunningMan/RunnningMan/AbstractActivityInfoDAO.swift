//
//  AbstractActivityInfoDAO.swift
//  RunningMan
//
//  Created by orient on 2017/1/6.
//  Copyright © 2017年 刘立冬. All rights reserved.
//

import Foundation
import Alamofire.Swift

open class AbstractActivityInfoDAO: NSObject {
    
    open var delegate: AbstractActivityInfoDAODelegate!
    
    open static let sharedInstance: AbstractActivityInfoDAO = {
        let instance = AbstractActivityInfoDAO()
        return instance
    }()
    
    //插入Note方法
    open func create(_ model: AbstarctActivityInfo) {
        
        let params = ["type": "JSON", "action": "add", "activityID":model.activityID,"activityName":model.activityName,
                      "userID":model.userID,"userName":model.userName,"activityDescription":model.activityDescription,
                      "organizedProfileURL":model.organizedProfileURL,"startData":model.startDate,"activityState":model.activityState]
        
        
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
    open func removeByUser(_ model: AbstarctActivityInfo) {
        
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
    open func removeByActivity(_ model: AbstarctActivityInfo) {
        
        let params = ["type": "JSON", "action": "remove", "activityID":model.activityID]
        
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
    
    open func removeByBoth(_ model: AbstarctActivityInfo) {
        
        let params = ["type": "JSON", "action": "remove", "userID":model.userID,"activityID":model.activityID]
        
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
    open func modify(_ model: AbstarctActivityInfo) {
        
        let params = ["type": "JSON", "action": "modify", "activityID":model.activityID,"activityName":model.activityName,
                      "userID":model.userID,"userName":model.userName,"activityDescription":model.activityDescription,
                      "organizedProfileURL":model.organizedProfileURL,"startData":model.startDate,"activityState":model.activityState]
        
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
                            let abstractactivityinfo=AbstarctActivityInfo()
                            let a_id=dic["activityID"]as!NSNumber
                            abstractactivityinfo.activityID=a_id.stringValue
                            abstractactivityinfo.activityName=dic["activityName"] as!String
                            let u_id=dic["userID"]as!NSNumber
                            abstractactivityinfo.userID=u_id.stringValue
                            abstractactivityinfo.userName=dic["userName"]as!String
                            abstractactivityinfo.activityDescription=dic["activityDescription"]as!String
                            abstractactivityinfo.organizedProfileURL=dic["organizedProfileURL"]as!String
                            abstractactivityinfo.startDate=dic["startDate"]as!String
                            abstractactivityinfo.activityState=dic["activityState"]as!String
                          
                            
                            listData.add(abstractactivityinfo)
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
                        let abstractactivityinfo=AbstarctActivityInfo()
                        let a_id=dic["activityID"]as!NSNumber
                        abstractactivityinfo.activityID=a_id.stringValue
                        abstractactivityinfo.activityName=dic["activityName"] as!String
                        let u_id=dic["userID"]as!NSNumber
                        abstractactivityinfo.userID=u_id.stringValue
                        abstractactivityinfo.userName=dic["userName"]as!String
                        abstractactivityinfo.activityDescription=dic["activityDescription"]as!String
                        abstractactivityinfo.organizedProfileURL=dic["organizedProfileURL"]as!String
                        abstractactivityinfo.startDate=dic["startDate"]as!String
                        abstractactivityinfo.activityState=dic["activityState"]as!String
                      
                        self.delegate.findByIdFinished?(abstractactivityinfo)
                        
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
