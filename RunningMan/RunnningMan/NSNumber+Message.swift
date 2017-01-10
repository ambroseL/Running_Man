//
//  NSNumber+Message.swift
//  RunningMan
//
//  Created by orient on 2017/1/6.
//  Copyright © 2017年 刘立冬. All rights reserved.
//

import Foundation

extension NSNumber {
    
    /*  -7 没有数据。
     *  	-6 日期没有输入。
     *  	-5 内容没有输入。
     *  	-4 ID没有输入。
     *  	-3 据访问失败。
     *	-2 您的账号最多能插入10条数据。
     *	-1 用户不存在，请到51work6.com注册。
     *	0 查询成功
     *	1 修改成功
     */
    var errorMessage : String {
        var errorStr = ""
        switch (self) {
        case -7:
            errorStr = "没有数据。"
        case -6:
            errorStr = "日期没有输入。"
        case -5:
            errorStr = "内容没有输入。"
        case -4:
            errorStr = "ID没有输入。"
        case -3:
            errorStr = "据访问失败。"
        case -2:
            errorStr = "您的账号最多能插入10条数据。"
        case -1:
            errorStr = "用户不存在，请到51work6.com注册。"
        default:
            errorStr = ""
        }
        return errorStr
    }
}

