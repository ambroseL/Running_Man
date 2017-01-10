//
//  PracticeRecordBLDelegate.swift
//  RunningMan
//
//  Created by yoli on 06/01/2017.
//  Copyright © 2017 刘立冬. All rights reserved.
//

import Foundation

@objc
public protocol ExerciseTimeBLDelegate{
    
    @objc optional func checkPracticeRecordStateFinished(state: Bool)
    
    @objc optional func checkPracticeRecordStateFailed(error: NSError)
    
    @objc optional func updatePracticeRecordStateFinished(state: Bool)
    
    @objc optional func updatePracticeRecordStateFalied(error: NSError)
}

