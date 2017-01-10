//
//  HealthInfoModule.swift
//  RunningMan
//
//  Created by yoli on 05/01/2017.
//  Copyright © 2017 刘立冬. All rights reserved.
//

import Foundation

@objc
open class HealthInfo: NSObject{
    
    open var userID: String
    open var dailyClimbingStairsGoal: Int
    open var weekClimbingStairsGoal: Int
    open var monthClimbingStairsGoal: Int
    open var dailyWalkingStepsGoal: Int
    open var weekWalkingStepsGoal: Int
    open var monthWalkingStepsGoal: Int
    open var dailyRunningDistanceGoal: Float
    open var weekRunningDistanceGoal: Float
    open var monthRunningDistanceGoal: Float
    open var dailyClimbingStairs: Int
    open var weekClimbingStairs: Int
    open var monthClimbingStairs: Int
    open var dailyWalkingSteps: Int
    open var weekWalkingSteps: Int
    open var monthWalkingSteps: Int
    open var dailyRunningDistance: Float
    open var weekRunningDistance: Float
    open var monthRunningDistance: Float
  
    
    public init(userID: String,
                dailyClimbingStairsGoal: Int, weekClimbingStairsGoal: Int, monthClimbingStairsGoal: Int,
                dailyWalkingStepsGoal: Int, weekWalkingStepsGoal: Int, monthWalkingStepsGoal: Int,
                dailyRunningDistanceGoal: Float, weekRunningDistanceGoal: Float, monthRunningDistanceGoal:Float,
                dailyClimbingStairs: Int, weekClimbingStairs: Int, monthClimbingStairs: Int,
                dailyWalkingSteps: Int, weekWalkingSteps: Int, monthWalkingSteps: Int,
                dailyRunningDistance: Float, weekRunningDistance: Float, monthRunningDistance: Float) {
        
        self.userID = userID
        self.dailyClimbingStairsGoal = dailyClimbingStairsGoal
        self.weekClimbingStairsGoal = weekClimbingStairsGoal
        self.monthClimbingStairsGoal = monthClimbingStairsGoal
        self.dailyWalkingStepsGoal = dailyWalkingStepsGoal
        self.weekWalkingStepsGoal = weekWalkingStepsGoal
        self.monthWalkingStepsGoal = weekWalkingStepsGoal
        self.dailyRunningDistanceGoal = dailyRunningDistanceGoal
        self.weekRunningDistanceGoal = weekRunningDistanceGoal
        self.monthRunningDistanceGoal = monthRunningDistanceGoal
        self.dailyClimbingStairs = dailyClimbingStairs
        self.weekClimbingStairs = weekClimbingStairs
        self.monthClimbingStairs = monthClimbingStairs
        self.dailyWalkingSteps = dailyWalkingSteps
        self.weekWalkingSteps = weekWalkingSteps
        self.monthWalkingSteps = monthWalkingSteps
        self.dailyRunningDistance = dailyRunningDistance
        self.weekRunningDistance = weekRunningDistance
        self.monthRunningDistance = monthRunningDistance
        
    }
    
    public override init(){
        
        self.userID = ""
        self.dailyClimbingStairsGoal = 0
        self.weekClimbingStairsGoal = 0
        self.monthClimbingStairsGoal = 0
        self.dailyWalkingStepsGoal = 0
        self.weekWalkingStepsGoal = 0
        self.monthWalkingStepsGoal = 0
        self.dailyRunningDistanceGoal = 0.0
        self.weekRunningDistanceGoal = 0.0
        self.monthRunningDistanceGoal = 0.0
        self.dailyClimbingStairs = 0
        self.weekClimbingStairs = 0
        self.monthClimbingStairs = 0
        self.dailyWalkingSteps = 0
        self.weekWalkingSteps = 0
        self.monthWalkingSteps = 0
        self.dailyRunningDistance = 0.0
        self.weekRunningDistance = 0.0
        self.monthRunningDistance = 0.0
        
    }
}
