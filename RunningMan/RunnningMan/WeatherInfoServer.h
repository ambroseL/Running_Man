//
//  WeatherAPI.h
//  test-4
//
//  Created by Yzc's mac on 2017/1/5.
//  Copyright © 2017年 Yzc's mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherInfoServerDelegate.h"

@interface WeatherInfoServer : NSObject

+ (instancetype)sharedInstance;

@property (weak, nonatomic) id <WeatherInfoServerDelegate> delegate;

//开始请求Web Service
- (void)find;


@end
