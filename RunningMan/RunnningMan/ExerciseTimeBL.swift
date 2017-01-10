//
//  PracticeRecordBL.swift
//  RunningMan
//
//  Created by yoli on 06/01/2017.
//  Copyright © 2017 刘立冬. All rights reserved.
//

import Foundation

public class ExerciseTime: NSObject ,ExerciseTimeDAODelegate{
    
    public var delegate: ExerciseTimeBLDelegate!
    
    public override init(){
        
    }
    //公共方法
    public func checkPracticeRecordState(model: ExerciseTimeInfo){
        let dao = ExerciseTimeDAO.sharedInstance
        dao.delegate = self
        dao.check(model)
    }
    
    public func updatePracticeRecordState(model: ExerciseTimeInfo){
        let dao = ExerciseTimeDAO.sharedInstance
        dao.delegate = self
        dao.modify(model)
    }
    
    //委托方法
    //检查成功
    public func checkFinished(state: Bool){
        self.delegate.checkPracticeRecordStateFinished?(state: state)
    }
    //检查失败
    public func checkFailed(error: NSError){
        self.delegate.checkPracticeRecordStateFailed?(error: error)
    }
    //更新成功
    public func updateFinished(state: Bool){
        self.delegate.updatePracticeRecordStateFinished?(state: state)
    }
    //更新失败
    public func updateFalied(error: NSError){
        self.delegate.updatePracticeRecordStateFalied?(error: error)
    }
    
}
