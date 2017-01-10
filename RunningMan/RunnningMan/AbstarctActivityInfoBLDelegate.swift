//
//  AbstarctActivityInfoBLDelegate.swift
//  RunningMan
//
//  Created by yoli on 06/01/2017.
//  Copyright © 2017 刘立冬. All rights reserved.
//

import Foundation

@objc
public protocol AbstarctActivityInfoBLDelegate{
    
    @objc optional func findAllAbstarctActivityInfoFinished(model: AbstarctActivityInfo)
    
    @objc optional func findAllAbstarctActivityInfoFailed(error: NSError)
    
    @objc optional func removeAbstarctActivityInfoFinished()
    
    @objc optional func removeAbstarctActivityInfoFailed(error: NSError)
    
    @objc optional func updateAbstarctActivityInfoFinished()
    
    @objc optional func updateAbstarctActivityInfoFailed(error: NSError)
    
}
