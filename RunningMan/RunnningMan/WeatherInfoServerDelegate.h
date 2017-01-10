//
//  WeatherServiceDelegate.h
//  test-4
//
//  Created by Yzc's mac on 2017/1/7.
//  Copyright © 2017年 Yzc's mac. All rights reserved.
//



@protocol WeatherInfoServerDelegate

@optional

//查询所有数据方法 成功
- (void)findWeatherFinished:(NSDictionary *) resDict;

//查询所有数据方法 失败
- (void)findWeatherFailed:(NSError *) error;

@end
