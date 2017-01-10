//
//  ReviewBLDegate.swift
//  RunningMan
//
//  Created by yoli on 06/01/2017.
//  Copyright © 2017 刘立冬. All rights reserved.
//

import Foundation

@objc
public protocol ReviewBLDelegate{
    
    @objc optional func createReviewFinished()
    
    @objc optional func createReviewFailed(error: NSError)
    
    @objc optional func findAllReviewFinished(model: UserSocialInfo)
    
    @objc optional func findAllReviewFailed(error: NSError)
}
