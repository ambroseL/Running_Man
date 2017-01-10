//
//  ActivityInfo.swift
//  RunningMan
//
//  Created by yoli on 05/01/2017.
//  Copyright © 2017 刘立冬. All rights reserved.
//

import Foundation

@objc
open class ActivityInfo: NSObject{
    
    open var activityID: String
    open var organizedName: String
    open var organizedProfileURL: String
    open var activityName: String
    open var startDate: String
    open var endDate: String
    open var Address: String
    open var contactInfo: String
    open var activityType: String
    open var memberThreshold: Int
    open var activityDescription: String
    
    public init(activityID: String, organizedName: String, organizedProfileURL: String, activityName: String, startDate: String, endDate: String, Address: String, contactInfo: String, activityType: String, memberThreshold: Int, activityDescription: String) {
        
        self.activityID = activityID
        self.organizedName = organizedName
        self.organizedProfileURL = organizedProfileURL
        self.activityName = activityName
        self.startDate = startDate
        self.endDate = endDate
        self.Address = Address
        self.contactInfo = contactInfo
        self.activityType = activityType
        self.memberThreshold = memberThreshold
        self.activityDescription = activityDescription
        
    }
    
    public override init(){
        
        self.activityID = ""
        self.organizedName = ""
        self.organizedProfileURL = ""
        self.activityName = ""
        self.startDate = ""
        self.endDate = ""
        self.Address = ""
        self.contactInfo = ""
        self.activityType = ""
        self.memberThreshold = 0
        self.activityDescription = ""
    }
}
