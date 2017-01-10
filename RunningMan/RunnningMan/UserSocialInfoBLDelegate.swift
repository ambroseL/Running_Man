//
//  UserSocialInfoBLDelegate.swift
//  RunningMan
//
//  Created by yoli on 06/01/2017.
//  Copyright © 2017 刘立冬. All rights reserved.
//

import Foundation

@objc
public protocol UserSocialInfoBLDelegate{
    
    @objc optional func findUserSocialInfoFinished(model: UserSocialInfo)
    
    @objc optional func findUserSocialInfoFailed(error: NSError)
    
    @objc optional func updateUserSocialInfoFinished()
    
    @objc optional func updateUserSocialInfoFailed(error: NSError)
    
}
