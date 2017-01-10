//
//  Review.swift
//  RunningMan
//
//  Created by yoli on 05/01/2017.
//  Copyright © 2017 刘立冬. All rights reserved.
//

import Foundation

@objc
open class Review: NSObject{
    
    open var userID: String
    open var reviewerID: String
    open var reviewerName: String
    open var reviewContent: String
    open var reviewProfileURL: String
    
    public init(userID: String, reviewerName: String, reviewerID: String, reviewContent: String, reviewProfileURL: String) {
        
        self.userID = userID
        self.reviewerID = reviewerID
        self.reviewerName = reviewerName
        self.reviewContent = reviewContent
        self.reviewProfileURL = reviewProfileURL
        
    }
    
    public override init(){
        
        self.userID = ""
        self.reviewerID = ""
        self.reviewerName = ""
        self.reviewContent = ""
        self.reviewProfileURL = ""
        
    }
}
