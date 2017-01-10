//
//  UserSocialInfoDAODelegate.swift
//  RunningMan
//
//  Created by orient on 2017/1/6.
//  Copyright © 2017年 刘立冬. All rights reserved.
//

import Foundation
@objc
public protocol UserSocialInfoDAODelegate {
    
    //查询所有数据方法 成功
    @objc optional func findAllFinished(_ list: NSMutableArray)
    
    //查询所有数据方法 失败
    @objc optional func findAllFailed(_ error: NSError)
    
    //按照主键查询数据方法 成功
    @objc optional func findByIdFinished(_ model: UserSocialInfo)
    
    //按照主键查询数据方法 失败
    @objc optional func findByIdFailed(_ error: NSError)
    
    //插入Note方法 成功
    @objc optional func createFinished()
    
    //插入Note方法 失败
    @objc optional func createFailed(_ error: NSError)
    
    //删除Note方法 成功
    @objc optional func removeFinished()
    
    //删除Note方法 失败
    @objc optional func removeFailed(_ error: NSError)
    
    //修改Note方法 成功
    @objc optional func modifyFinished()
    
    //修改Note方法 失败
    @objc optional func modifyFailed(_ error: NSError)
    
}
