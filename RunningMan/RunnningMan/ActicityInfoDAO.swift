//
//  ActicityInfoDAO.swift
//  RunningMan
//
//  Created by orient on 2017/1/6.
//  Copyright © 2017年 刘立冬. All rights reserved.
//

import Foundation
import Alamofire.Swift


open class ActivityInfoDAO: NSObject {
    
    open var delegate: ActivityInfoDAODelegate!
    
    open static let sharedInstance: ActivityInfoDAO = {
        let instance = ActivityInfoDAO()
        return instance
    }()
    
    //插入Note方法
    open func create(_ model: ActivityInfo) {
        
        let params = ["type": "JSON", "action": "add", "activityID":model.activityID,"organizedName":model.organizedName,
                      "organizedProfileURL":model.organizedProfileURL,"activityName":model.activityName,"startDate":model.startDate,"endDate":model.endDate,"Address":model.Address,"contactInfo":model.contactInfo,"memberThreshold":model.memberThreshold,"activityDescription":model.activityDescription] as [String : Any]
        
        
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
    open func remove(_ model: ActivityInfo) {
        
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
    
    //修改Note方法
    open func modify(_ model: ActivityInfo) {
        
        let params = ["type": "JSON", "action": "modify", "activityID":model.activityID,"organizedName":model.organizedName,
                      "organizedProfileURL":model.organizedProfileURL,"activityName":model.activityName,"startDate":model.startDate,"endDate":model.endDate,"Address":model.Address,"contactInfo":model.contactInfo,"memberThreshold":model.memberThreshold,"activityDescription":model.activityDescription] as [String : Any]
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
                            let activityinfo=ActivityInfo()
                            let a_id=dic["activityID"]as!NSNumber
                            activityinfo.activityID=a_id.stringValue
                            activityinfo.activityName=dic["activityinfo"]as!String
                            activityinfo.organizedName=dic["organizedName"]as!String
                            activityinfo.organizedProfileURL=dic["organizedProfileURL"]as!String
                            activityinfo.startDate=dic["startDate"]as!String
                            activityinfo.endDate=dic["endDate"]as!String
                            activityinfo.Address=dic["Address"]as!String
                            activityinfo.contactInfo=dic["contactInfo"]as!String
                            activityinfo.activityType=dic["activityType"]as!String
                            let mem=dic["Description"]as!NSNumber
                            activityinfo.memberThreshold=mem.intValue
                            activityinfo.activityDescription=dic["activityDescription"]as!String
                    
                            
                            listData.add(activityinfo)
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
    open func findById(_ model: ActivityInfo) {
        
        let params = ["type": "JSON", "action": "query", "activityID":model.activityID]
        
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
                        let activityinfo=ActivityInfo()
                        let a_id=dic["activityID"]as!NSNumber
                        activityinfo.activityID=a_id.stringValue
                        activityinfo.activityName=dic["activityinfo"]as!String
                        activityinfo.organizedName=dic["organizedName"]as!String
                        activityinfo.organizedProfileURL=dic["organizedProfileURL"]as!String
                        activityinfo.startDate=dic["startDate"]as!String
                        activityinfo.endDate=dic["endDate"]as!String
                        activityinfo.Address=dic["Address"]as!String
                        activityinfo.contactInfo=dic["contactInfo"]as!String
                        activityinfo.activityType=dic["activityType"]as!String
                        let mem=dic["Description"]as!NSNumber
                        activityinfo.memberThreshold=mem.intValue
                        activityinfo.activityDescription=dic["activityDescription"]as!String
                       
                        self.delegate.findByIdFinished?(activityinfo)
                        
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
