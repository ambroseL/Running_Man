//
//  AbstarctActivityInfoBL.swift
//  RunningMan
//
//  Created by yoli on 06/01/2017.
//  Copyright © 2017 刘立冬. All rights reserved.
//

import Foundation

public class AbstarctActivityInfoBL: NSObject, AbstractActivityInfoDAODelegate{
    
    public var delegate: AbstarctActivityInfoBLDelegate!
    
    public override init(){
        
    }
    //公共方法
    public func findAllAbstarctActivityInfo(){
        let dao = AbstractActivityInfoDAO.sharedInstance
        dao.delegate = self
        dao.findAll()
    }
    
    public func removeAbstarctActivityInfo(model: AbstarctActivityInfo){
        let dao = AbstractActivityInfoDAO.sharedInstance
        dao.delegate = self
        dao.removeByUser(model)
    }
    
    public func updateAbstarctActivityInfo(model: AbstarctActivityInfo){
        let dao = AbstractActivityInfoDAO.sharedInstance
        dao.delegate = self
        dao.modify(model)
    }
    
    //委托方法
    //查询成功
    public func findFinished(model: AbstarctActivityInfo){
        self.delegate.findAllAbstarctActivityInfoFinished?(model: model)
    }
    //查询失败
    public func findFailed(error: NSError){
        self.delegate.findAllAbstarctActivityInfoFailed?(error: error)
    }
    //删除成功
    public func removeFinished(){
        self.delegate.removeAbstarctActivityInfoFinished?()
    }
    //删除失败
    public func removeFailed(error: NSError){
        self.delegate.removeAbstarctActivityInfoFailed?(error: error)
    }
    //更新成功
    public func updateFinished(){
        self.delegate.updateAbstarctActivityInfoFinished?()
    }
    //更新失败
    public func updateFailed(error: NSError){
        self.delegate.updateAbstarctActivityInfoFailed?(error: error)
    }
    
    
}
