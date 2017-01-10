//
//  AdvertisingActivityInfoBL.swift
//  RunningMan
//
//  Created by yoli on 06/01/2017.
//  Copyright © 2017 刘立冬. All rights reserved.
//

import Foundation

public class AdvertisingActivityInfoBL: NSObject, AdvertisingActivityInfoDAODelegate{
    
    public var delegate: AdvertisingActivityInfoBLDelegate!
    
    public override init(){
        
    }
    //公共方法
    public func findAllAdvertisingActivityInfo(){
        let dao = AdvertisingActivityInfoDAO.sharedInstance
        dao.delegate = self
        dao.findAll()
    }
    
    //委托方法
    //查询成功
    public func findFinished(model: AdvertisingActivityInfo){
        self.delegate.findAllAdvertisingActivityInfoFinished?(model: model)
    }
    
    //查询失败
    public func findFailed(error: NSError){
        self.delegate.findAllAdvertisingActivityInfoFailed?(error: error)
    }
    
}
