//
//  u.swift
//  RunningMan
//
//  Created by yoli on 05/01/2017.
//  Copyright © 2017 刘立冬. All rights reserved.
//

import Foundation

@objc
open class UserKeyInfo: NSObject{
    
    open var userID: String
    open var userName: String
    open var Pwd: String
    open var mailAddress: String
    open var studentID: String
    open var identityID: String
    open var Sex: String

    
    public init(userID: String, userName: String, Pwd: String, mailAddress: String, studentID: String, identityID: String, Sex: String){
        self.userID = userID;
        self.userName = userName
        self.Pwd = Pwd
        self.mailAddress = mailAddress
        self.studentID = studentID
        self.identityID = identityID
        self.Sex = Sex
    }
    
    public override init(){
        self.userID = ""
        self.userName = ""
        self.Pwd = ""
        self.mailAddress = ""
        self.studentID = ""
        self.identityID = ""
        self.Sex = ""
    }
    
}
