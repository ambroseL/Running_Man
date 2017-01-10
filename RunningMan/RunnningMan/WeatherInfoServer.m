//
//  WeatherAPI.m
//  test-4
//
//  Created by Yzc's mac on 2017/1/5.
//  Copyright © 2017年 Yzc's mac. All rights reserved.
//

#import "WeatherInfoServer.h"
#import <CommonCrypto/CommonDigest.h>

@interface WeatherInfoServer()

@end

@implementation WeatherInfoServer

+ (instancetype)sharedInstance
{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

#pragma mark - 开始请求Web Service

- (void)find {
    NSLog((@"second find!"));
    NSString *strURL = [[NSString alloc] initWithFormat:@"http://v.juhe.cn/weather/index?format=2&cityname=16&key=3156fa4e8f868e948c407a5ed16b660c"];
    
    strURL = [strURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURL *url = [NSURL URLWithString:strURL];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSURLSessionConfiguration *defaultConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration: defaultConfig delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:
        ^(NSData *data, NSURLResponse *response, NSError *error) {
            NSLog(@"请求完成...");
            if (!error) {
                
                NSString *receiveStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                
                NSData *data1 = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
                
                NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:data1 options:NSJSONReadingMutableLeaves error:nil];
                
                NSNumber *resultCodeNumber = [resDict objectForKey:@"resultcode"];
                NSInteger resultCode = [resultCodeNumber integerValue];
                if (resultCode == 200) {
                    resDict = [resDict objectForKey:@"result"];
                    resDict = [resDict objectForKey:@"today"];
                    
                    NSDictionary *resskDict = [resDict objectForKey:@"sk"];
                    
                    NSDictionary *sendData = [NSDictionary dictionaryWithObjectsAndKeys:[resDict objectForKey:@"weather"], @"Weather", [resDict objectForKey:@"temperature"], @"Temperature", [resDict objectForKey:@"wind"], @"Wind", [resDict objectForKey:@"dressing_index"], @"Dressing_index", [resskDict objectForKey:@"humidity"], @"Humidity", nil];
                    NSLog((@"third find!"));
                    [self.delegate findWeatherFinished: sendData];
                    //NSLog(@"result code: %@",sendData);
                }
                else {
                    [self.delegate findWeatherFailed:error];
                }
                
            } else {
                [self.delegate findWeatherFailed:error];
                NSLog(@"error : %@", error.localizedDescription);
            }
        }];
    
    [task resume];
    
}

@end
