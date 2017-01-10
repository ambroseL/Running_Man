//
//  UserKeyInfoBLDelegate.swift
//  RunningMan
//
//  Created by yoli on 06/01/2017.
//  Copyright © 2017 刘立冬. All rights reserved.
//

import Foundation

@objc
public protocol UserKeyInfoBLDelegate{
    
    @objc optional func createUserKeyInfofinished()
    
    @objc optional func createUserKeyInfoFailed(error: NSError)
    
    @objc optional func checkValidationFinished()
    
    @objc optional func checkValidationFailed(error: NSError)
    
    //    optional func modifyUserKeyInfoFinished()
    //
    //    optional func modifyUserKeyInfoFailed(error)
    
}
