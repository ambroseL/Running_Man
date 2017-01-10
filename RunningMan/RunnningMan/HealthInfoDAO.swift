//
//  HealthInfoDAO.swift
//  RunningMan
//
//  Created by orient on 2017/1/6.
//  Copyright © 2017年 刘立冬. All rights reserved.
//

import Foundation
import Alamofire.Swift

open class HealthInfoDAO: NSObject {
    
    open var delegate: HealthInfoDAODelegate!
    
    open static let sharedInstance: HealthInfoDAO = {
        let instance = HealthInfoDAO()
        return instance
    }()
    
    //插入Note方法
    open func create(_ model: HealthInfo) {
        
        let params = ["type": "JSON", "action": "add", "userID":model.userID,"dailyClimbingStairsGoal":model.dailyClimbingStairsGoal,"monthClimbingStairsGoal":model.monthClimbingStairsGoal,"weekClimbingStairsGoal":model.weekClimbingStairsGoal,"dailyWallkingStepsGoal":model.dailyWalkingStepsGoal,"weekWalkingStepsGoal":model.weekWalkingStepsGoal,"monthWalkingStepsGoal":model.monthWalkingStepsGoal,"dailyRunningDistanceGoal":model.dailyRunningDistanceGoal,"weekRunningDistanceGoal":model.weekRunningDistanceGoal,"monthRunningDistanceGoal":model.monthRunningDistanceGoal,"dailyRunningDistance":model.dailyRunningDistance,"weekRunningDistance":model.weekRunningDistance,"monthRunningDistance":model.monthRunningDistance] as [String : Any]
        
        
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
    open func remove(_ model: HealthInfo) {
        
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
    open func modify(_ model: HealthInfo) {
        
      let params = ["type": "JSON", "action": "modify", "userID":model.userID,"dailyClimbingStairsGoal":model.dailyClimbingStairsGoal,"monthClimbingStairsGoal":model.monthClimbingStairsGoal,"weekClimbingStairsGoal":model.weekClimbingStairsGoal,"dailyWallkingStepsGoal":model.dailyWalkingStepsGoal,"weekWalkingStepsGoal":model.weekWalkingStepsGoal,"monthWalkingStepsGoal":model.monthWalkingStepsGoal,"dailyRunningDistanceGoal":model.dailyRunningDistanceGoal,"weekRunningDistanceGoal":model.weekRunningDistanceGoal,"monthRunningDistanceGoal":model.monthRunningDistanceGoal,"dailyRunningDistance":model.dailyRunningDistance,"weekRunningDistance":model.weekRunningDistance,"monthRunningDistance":model.monthRunningDistance] as [String : Any]
       
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
                            let healthinfo=HealthInfo()
                            let u_id=dic["userID"] as! NSNumber
                            healthinfo.userID=u_id.stringValue
                            let d_csg=dic["dailyClimbingStairsGoal"] as! NSNumber
                            healthinfo.dailyClimbingStairsGoal=d_csg.intValue
                            let m_csg=dic["monthClimbingStairsGoal"] as! NSNumber
                            healthinfo.monthClimbingStairsGoal=m_csg.intValue
                            let w_csg=dic["weekClimbingStairGoal"] as! NSNumber
                            healthinfo.weekClimbingStairsGoal=w_csg.intValue
                            
                            let d_wsg=dic["dailyWalkingStepsGoal"] as!NSNumber
                            healthinfo.dailyWalkingStepsGoal=d_wsg.intValue
                            let w_wsg=dic["weekWalkingStepsGoal"] as!NSNumber
                            healthinfo.weekWalkingStepsGoal=w_wsg.intValue
                            let m_wsg=dic["monthWalkingStepsGoal"] as!NSNumber
                            healthinfo.monthWalkingStepsGoal=m_wsg.intValue
                            
                            
                            let d_rsg=dic["dailyRunningDistanceGoal"] as!NSNumber
                            healthinfo.dailyRunningDistanceGoal=d_rsg.floatValue
                            let w_rsg=dic["weekRunningDistanceGoal"] as!NSNumber
                            healthinfo.weekRunningDistanceGoal=w_rsg.floatValue
                            let m_rsg=dic["monthRunningDistanceGoal"] as!NSNumber
                            healthinfo.monthRunningDistanceGoal=m_rsg.floatValue
                            
                            let d_rs=dic["dailyRunningDistance"] as!NSNumber
                            healthinfo.dailyRunningDistance=d_rs.floatValue
                            let w_rs=dic["weekRunningDistance"] as!NSNumber
                            healthinfo.weekRunningDistance=w_rs.floatValue
                            let m_rs=dic["monthRunningDistance"] as!NSNumber
                            healthinfo.monthRunningDistance=m_rs.floatValue
                      
                        
                            let d_cs=dic["dailyClimbingStairs"] as! NSNumber
                            healthinfo.dailyClimbingStairsGoal=d_cs.intValue
                            let m_cs=dic["monthClimbingStairs"] as! NSNumber
                            healthinfo.monthClimbingStairsGoal=m_cs.intValue
                            let w_cs=dic["weekClimbingStair"] as! NSNumber
                            healthinfo.weekClimbingStairsGoal=w_cs.intValue
                            
                            let d_ws=dic["dailyWalkingSteps"] as!NSNumber
                            healthinfo.dailyWalkingStepsGoal=d_ws.intValue
                            let w_ws=dic["weekWalkingSteps"] as!NSNumber
                            healthinfo.weekWalkingStepsGoal=w_ws.intValue
                            let m_ws=dic["monthWalkingSteps"] as!NSNumber
                            healthinfo.monthWalkingStepsGoal=m_ws.intValue
                            
                            listData.add(healthinfo)
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
    open func findById(_ model: HealthInfo) {
        
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
                        
                        let healthinfo=HealthInfo()
                        let u_id=dic["userID"] as! NSNumber
                        healthinfo.userID=u_id.stringValue
                        let d_csg=dic["dailyClimbingStairsGoal"] as! NSNumber
                        healthinfo.dailyClimbingStairsGoal=d_csg.intValue
                        let m_csg=dic["monthClimbingStairsGoal"] as! NSNumber
                        healthinfo.monthClimbingStairsGoal=m_csg.intValue
                        let w_csg=dic["weekClimbingStairGoal"] as! NSNumber
                        healthinfo.weekClimbingStairsGoal=w_csg.intValue
                        
                        let d_wsg=dic["dailyWalkingStepsGoal"] as!NSNumber
                        healthinfo.dailyWalkingStepsGoal=d_wsg.intValue
                        let w_wsg=dic["weekWalkingStepsGoal"] as!NSNumber
                        healthinfo.weekWalkingStepsGoal=w_wsg.intValue
                        let m_wsg=dic["monthWalkingStepsGoal"] as!NSNumber
                        healthinfo.monthWalkingStepsGoal=m_wsg.intValue
                        
                        
                        let d_rsg=dic["dailyRunningDistanceGoal"] as!NSNumber
                        healthinfo.dailyRunningDistanceGoal=d_rsg.floatValue
                        let w_rsg=dic["weekRunningDistanceGoal"] as!NSNumber
                        healthinfo.weekRunningDistanceGoal=w_rsg.floatValue
                        let m_rsg=dic["monthRunningDistanceGoal"] as!NSNumber
                        healthinfo.monthRunningDistanceGoal=m_rsg.floatValue
                        
                        let d_rs=dic["dailyRunningDistance"] as!NSNumber
                        healthinfo.dailyRunningDistance=d_rs.floatValue
                        let w_rs=dic["weekRunningDistance"] as!NSNumber
                        healthinfo.weekRunningDistance=w_rs.floatValue
                        let m_rs=dic["monthRunningDistance"] as!NSNumber
                        healthinfo.monthRunningDistance=m_rs.floatValue
                        
                        
                        
                        let d_cs=dic["dailyClimbingStairs"] as! NSNumber
                        healthinfo.dailyClimbingStairsGoal=d_cs.intValue
                        let m_cs=dic["monthClimbingStairs"] as! NSNumber
                        healthinfo.monthClimbingStairsGoal=m_cs.intValue
                        let w_cs=dic["weekClimbingStair"] as! NSNumber
                        healthinfo.weekClimbingStairsGoal=w_cs.intValue
                        
                        let d_ws=dic["dailyWalkingSteps"] as!NSNumber
                        healthinfo.dailyWalkingStepsGoal=d_ws.intValue
                        let w_ws=dic["weekWalkingSteps"] as!NSNumber
                        healthinfo.weekWalkingStepsGoal=w_ws.intValue
                        let m_ws=dic["monthWalkingSteps"] as!NSNumber
                        healthinfo.monthWalkingStepsGoal=m_ws.intValue
                    
                        
                        self.delegate.findByIdFinished?(healthinfo)
                        
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
