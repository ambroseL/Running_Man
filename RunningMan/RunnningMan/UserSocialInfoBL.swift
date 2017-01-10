//
//  UserSocialInfoBL.swift
//  RunningMan
//
//  Created by yoli on 06/01/2017.
//  Copyright © 2017 刘立冬. All rights reserved.
//

import Foundation

public class UserSocialInfoBL: NSObject, UserSocialInfoDAODelegate{
    
    public var delegate: UserSocialInfoBLDelegate!
    
    public override init(){
        
    }
    //公共方法
    public func findUserSocialInfo(){
        let dao = UserSocialInfoDAO.sharedInstance
        dao.delegate = self
        dao.findAll()
    }
    
    public func updateUserSoicialInfo(model: UserSocialInfo){
        let dao = UserSocialInfoDAO.sharedInstance
        dao.delegate = self
        dao.modify(model)
    }
    //委托方法
    //查询成功
    public func findFinished(model: UserSocialInfo){
        self.delegate.findUserSocialInfoFinished?(model: model)
    }
    //查询失败
    public func findFailed(_ error: NSError){
        self.delegate.findUserSocialInfoFailed?(error: error)
    }
    //更新成功
    public func updateFinished(){
        self.delegate.updateUserSocialInfoFinished?()
    }
    //更新失败
    public func updateFailed(error: NSError){
        self.delegate.updateUserSocialInfoFailed?(error: error)
    }
    
}
