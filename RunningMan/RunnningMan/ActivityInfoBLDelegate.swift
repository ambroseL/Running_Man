//
//  ActivityInfoBLDelegate.swift
//  RunningMan
//
//  Created by yoli on 06/01/2017.
//  Copyright © 2017 刘立冬. All rights reserved.
//

import Foundation

@objc
public protocol ActivityInfoBLDelegate{
    
    @objc optional func createActivityInfoFinished()
    
    @objc optional func createActivityInfoFailed(error: NSError)
    
    @objc optional func findActivityInfoFinished(model: ActivityInfo)
    
    @objc optional func findActivityInfoFailed(error: NSError)
    
}
