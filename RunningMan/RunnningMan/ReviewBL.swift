//
//  ReviewBL.swift
//  RunningMan
//
//  Created by yoli on 06/01/2017.
//  Copyright © 2017 刘立冬. All rights reserved.
//


import Foundation

public class ReviewBL: NSObject, ReviewDAODelegate{
    
    public var delegate: ReviewBLDelegate!
    
    public override init(){
        
    }
    //公共方法
    public func createReview(model: Review){
        let dao = ReviewDAO.sharedInstance
        dao.delegate = self
        dao.create(model)
    }
    
    public func findAllReview(){
        let dao = ReviewDAO.sharedInstance
        dao.delegate = self
        dao.findAll()
    }
    
    //委托方法
    //创建成功
    public func createFinished(){
        self.delegate.createReviewFinished?()
    }
    //创建失败
    public func createReviewFailed(error: NSError){
        self.delegate.createReviewFailed?(error: error)
    }
    //查询成功
    public func findFinished(model: UserSocialInfo){
        self.delegate.findAllReviewFinished?(model: model)
    }
    //查询失败
    public func findFailed(error: NSError){
        self.delegate.findAllReviewFailed?(error: error)
    }
}
