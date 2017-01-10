//
//  ActivityInfoBL.swift
//  RunningMan
//
//  Created by yoli on 06/01/2017.
//  Copyright © 2017 刘立冬. All rights reserved.
//

import Foundation

public class ActivityInfoBL: NSObject, ActivityInfoDAODelegate{
    
    public var delegate: ActivityInfoBLDelegate!
    
    public override init(){
        
    }
    //公共方法
    public func createActivityInfo(model: ActivityInfo){
        let dao = ActivityInfoDAO.sharedInstance
        dao.delegate = self
        dao.create(model)
    }
    
    public func findActivityInfo(){
        let dao = ActivityInfoDAO.sharedInstance
        dao.delegate = self
        dao.findAll()
    }
    //委托方法
    //创建成功
    public func createFinished(){
        self.delegate.createActivityInfoFinished?()
    }
    //创建失败
    public func createFailed(error: NSError){
        self.delegate.createActivityInfoFailed?(error: error)
    }
    //查询成功
    public func findFinished(model: ActivityInfo){
        self.delegate.findActivityInfoFinished?(model: model)
    }
    //查询失败
    public func findFailed(error: NSError){
        self.delegate.findActivityInfoFailed?(error: error)
    }
}
