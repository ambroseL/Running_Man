//
//  AdvertisingActivityInfo.swift
//  RunningMan
//
//  Created by yoli on 05/01/2017.
//  Copyright © 2017 刘立冬. All rights reserved.
//

import Foundation

@objc
open class AdvertisingActivityInfo: NSObject{
    
    open var activityImageURL: String
    open var activityID: String
    
    public init(activityImageURL: String, activityID:String) {
        
        self.activityImageURL = activityImageURL
        self.activityID = activityID
        
    }
    
    public override init(){
        
        self.activityImageURL = ""
        self.activityID = ""
        
    }
}
