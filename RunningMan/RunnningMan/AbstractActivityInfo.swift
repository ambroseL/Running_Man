//
//  AbstractActivityInfo.swift
//  RunningMan
//
//  Created by yoli on 05/01/2017.
//  Copyright © 2017 刘立冬. All rights reserved.
//

import Foundation

@objc
open class AbstarctActivityInfo: NSObject{
    
    open var activityID: String
    open var activityName: String
    open var userID: String
    open var userName: String
    open var activityDescription: String
    open var organizedProfileURL: String
    open var startDate: String
    open var activityState: String
    
    public init(activityID: String, activityName: String, userID: String, userName: String, activityDescription: String, organizedProfileURL: String, startDate: String, activityState: String) {
        
        self.activityID = activityID
        self.activityName = activityName
        self.userID = userID
        self.userName = userName
        self.activityDescription = activityDescription
        self.organizedProfileURL = organizedProfileURL
        self.startDate = startDate
        self.activityState = activityState
        
    }
    
    public override init(){
        
        self.activityID = ""
        self.activityName = ""
        self.userID = ""
        self.userName = ""
        self.activityDescription = ""
        self.organizedProfileURL = ""
        self.startDate = ""
        self.activityState = ""
    }
}
