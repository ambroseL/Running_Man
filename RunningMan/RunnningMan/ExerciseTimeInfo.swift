//
//  ExerciseTimeInfo.swift
//  RunningMan
//
//  Created by orient on 2017/1/6.
//  Copyright © 2017年 刘立冬. All rights reserved.
//

import Foundation
@objc
open class ExerciseTimeInfo: NSObject{
    
    open var userID:String
    open var exerciseTime:String
    
    public init(userID: String, exerciseTime:String) {
        
        self.userID=userID
        self.exerciseTime=exerciseTime
        
    }
    
    public override init(){
        self.userID=""
        self.exerciseTime=""
    }
}
