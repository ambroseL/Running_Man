//
//  HealthKitServerDelegate.h
//  test-4
//
//  Created by Yzc's mac on 2017/1/10.
//  Copyright © 2017年 Yzc's mac. All rights reserved.
//

@protocol HealthKitInfoServerDelegate

@optional

//得到步数 成功
- (void)getStepCountForDayFinished:(NSInteger) resData;

//得到已爬楼层 成功
- (void)getClimbedForDayFinished:(NSInteger) resData;

//得到跑步时的距离 成功
- (void)getPartDistanceForStartDateFinished:(double) resData;

//得到步数 失败
- (void)getStepCountForDayFailed:(NSError *) error;

//得到已爬楼层 失败
- (void)getClimbedForDayFailed:(NSError *) error;

//得到跑步时的距离 失败
- (void)getPartDistanceForStartDateFailed:(NSError *) error;

//申请读取步数 成功
- (void)authorizeHealthKitForStepFinished;

//申请读取已爬楼层 成功
- (void)authorizeHealthKitForClimbedFinished;

//申请读取步数 失败
- (void)authorizeHealthKitForStepFailed:(NSError *) error;

//申请读取已爬楼层 失败
- (void)authorizeHealthKitForClimbedFailed:(NSError *) error;

@end
