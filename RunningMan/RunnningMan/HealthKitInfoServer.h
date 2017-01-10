//
//  HealthKitManage.h
//  test-4
//
//  Created by Yzc's mac on 2016/12/26.
//  Copyright © 2016年 Yzc's mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HealthKit/HealthKit.h>
#import <UIKit/UIDevice.h>
#import "HealthKitInfoServerDelegate.h"

#define HKVersion [[[UIDevice currentDevice] systemVersion] doubleValue]
#define CustomHealthErrorDomain @"com.sdqt.healthError"

@interface HealthKitInfoServer : NSObject

@property (nonatomic, strong) HKHealthStore *healthStore;

+ (id)shareInstance;

@property (weak, nonatomic) id <HealthKitInfoServerDelegate> delegate;
//获取权限 要输入类型
- (void)authorizeHealthKit:(NSString *) type;

- (NSSet *)dataTypesToWrite;

- (NSSet *)dataTypesRead;

- (void)getStepCountForDay:(NSInteger) day;

- (void)getClimbedForDay:(NSInteger) day;

- (void)getPartDistanceForStartDate:(NSDate *) startDate;

+ (NSPredicate *)predicate:(NSInteger)day;

+ (NSPredicate *)predicateByStartDate:(NSDate *)startDate;
@end
