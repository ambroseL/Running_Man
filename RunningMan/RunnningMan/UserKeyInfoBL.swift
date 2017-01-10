//
//  UserKeyInfoBL.swift
//  RunningMan
//
//  Created by yoli on 06/01/2017.
//  Copyright © 2017 刘立冬. All rights reserved.
//

import Foundation

public class UserKetInfoBL: NSObject, UserKeyInfoDAODelegate{
    
    public var delegate: UserKeyInfoBLDelegate!
    
    public override init(){
        
    }
    //公共方法
    public func createUserKeyInfo(model: UserKeyInfo){
        let dao = UserKeyInfoDAO.sharedInstance
        dao.delegate = self
        dao.create(model)
    }
    
    public func checkValidation(model: UserKeyInfo){
        let dao = UserKeyInfoDAO.sharedInstance
        dao.delegate = self
        dao.check(model)
    }
    
    //委托方法
    //创建成功
    public func createFinished(){
        self.delegate.createUserKeyInfofinished?()
    }
    //创建失败
    public func createFailed(_ error: NSError){
        self.delegate.createUserKeyInfoFailed?(error: error)
    }
    //验证成功
    public func checkFinished(){
        self.delegate.checkValidationFinished?()
    }
    //验证失败
    public func checkFailed(error: NSError){
        self.delegate.checkValidationFailed?(error: error)
    }
    
    
    
    
}
