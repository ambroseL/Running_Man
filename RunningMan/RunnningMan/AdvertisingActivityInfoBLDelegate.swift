//
//  AdvertisingActivityInfoBLDelegate.swift
//  RunningMan
//
//  Created by yoli on 06/01/2017.
//  Copyright © 2017 刘立冬. All rights reserved.
//

import Foundation

@objc
public protocol AdvertisingActivityInfoBLDelegate{
    
    @objc optional func findAllAdvertisingActivityInfoFinished(model: AdvertisingActivityInfo)
    
    @objc optional func findAllAdvertisingActivityInfoFailed(error: NSError)
    
}
