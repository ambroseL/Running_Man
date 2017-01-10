//
//  HealthInfoBL1.swift
//  RunningMan
//
//  Created by orient on 2017/1/10.
//  Copyright © 2017年 刘立冬. All rights reserved.
//

import Foundation

public class HealthInfoBL: NSObject, HealthInfoDAODelegate{
    
    public var delegate: HealthInfoBLDelegate!
    
    public override init(){
        
    }
    //公共方法
    public func findHealthInfo(){
        let dao = HealthInfoDAO.sharedInstance
        dao.delegate = self
        dao.findAll()//查询数据库里的累计公里数
    }
    
    //委托方法
    //查询成功
    public func findFinished(model: HealthInfo){
        /*
         对model进行healthkit数据的补充
         */
        self.delegate.findHealthInfoFinished?(model: model)
    }
    //查询失败
    public func findFailed(error: NSError){
        self.delegate.findHealthInfoFailed?(error: error)
    }
}
