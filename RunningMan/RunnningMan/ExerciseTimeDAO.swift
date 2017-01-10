//
//  ExerciseTimeDAO.swift
//  RunningMan
//
//  Created by orient on 2017/1/6.
//  Copyright © 2017年 刘立冬. All rights reserved.
//

import Foundation

import Alamofire.Swift


open class ExerciseTimeDAO: NSObject {
    
    open var delegate: ExerciseTimeDAODelegate!
    
    open static let sharedInstance: ExerciseTimeDAO = {
        let instance = ExerciseTimeDAO()
        return instance
    }()
    
    //插入Note方法
    open func create(_ model:ExerciseTimeInfo) {
        
        let params = ["type": "JSON", "action": "add", "userID":model.userID,"exerciseTime":model.exerciseTime]
        
        
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
    open func remove(_ model: ExerciseTimeInfo) {
        
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
    open func modify(_ model:ExerciseTimeInfo) {
        
        let params = ["type": "JSON", "action": "modify", "userID":model.userID,"exerciseTime":model.exerciseTime]
        

        
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
                            let exercisetimeinfo=ExerciseTimeInfo()
                            let u_id = dic["userID"] as! NSNumber
                            exercisetimeinfo.userID=u_id.stringValue
                            exercisetimeinfo.exerciseTime=dic["exerciseTime"]as!String
                        
                            
                            listData.add(exercisetimeinfo)
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
    open func check(_ model:ExerciseTimeInfo) {
        
       let params = ["type": "JSON", "action": "check", "userID":model.userID,"exerciseTime":model.exerciseTime]
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
    open func findById(_ model: ExerciseTimeInfo) {
        
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
                        let exercisetimeinfo=ExerciseTimeInfo()
                        let u_id = dic["userID"] as! NSNumber
                        exercisetimeinfo.userID=u_id.stringValue
                        exercisetimeinfo.exerciseTime=dic["exerciseTime"]as!String
                        
                        self.delegate.findByIdFinished?(exercisetimeinfo)
                        
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
