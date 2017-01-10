//
//  UserSocialInfoModule.swift
//  RunningMan
//
//  Created by yoli on 05/01/2017.
//  Copyright © 2017 刘立冬. All rights reserved.
//

import Foundation

@objc
open class UserSocialInfo: NSObject{
    
    open var userID: String
    open var userName: String
    open var Sex: String
    open var Signature: String
    open var likeNum: Int
    open var participatedActivitiesNum: Int
    open var organizedActivitiesNum: Int
    open var exercisetimes:Int
    
    public init(userID: String, userName: String, Sex: String, Signature: String, likeNum: Int, participatedActivitiesNum: Int, organizedActivitiesNum: Int,exercisetimes:Int) {
        
        
        self.userID = userID
        self.userName = userName
        self.Sex = Sex
        self.Signature = Signature
        self.likeNum = likeNum
        self.participatedActivitiesNum = participatedActivitiesNum
        self.organizedActivitiesNum = organizedActivitiesNum
        self.exercisetimes=exercisetimes
        
    }
    
    public override init(){
        
        self.userID = ""
        self.userName = ""
        self.Sex = ""
        self.Signature = ""
        self.likeNum = 0
        self.participatedActivitiesNum = 0
        self.organizedActivitiesNum = 0
        self.exercisetimes=0
        
    }
}
