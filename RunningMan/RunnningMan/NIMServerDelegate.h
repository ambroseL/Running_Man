//
//  NIMServerDelegate.h
//  test-4
//
//  Created by Yzc's mac on 2017/1/7.
//  Copyright © 2017年 Yzc's mac. All rights reserved.
//

@protocol NIMServerDelegate

@optional

//发送短信验证码 成功
- (void)sendCodeFinished;

//发送短信验证码 失败
- (void)sendCodeFailed:(NSError *) error;

//验证短信验证码 成功
- (void)verifyCodeFinished;

//验证短信验证码 失败
- (void)verifyCodeFailed:(NSError *) error;


@end
