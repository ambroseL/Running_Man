//
//  NIMServerAPI.m
//  ObjcServerAPI
//
//  Created by amao on 2/26/16.
//  Copyright © 2016 Netease. All rights reserved.
//

#import "NIMServer.h"
#import <CommonCrypto/CommonDigest.h>

@interface NSString (NIMSHA1)
@end
@implementation NSString(NIMSHA1)
- (NSString *)nim_sha1
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

@end


@interface NIMServer ()
@property (nonatomic,copy)  NSString    *appKey;
@property (nonatomic,copy)  NSString    *appSecret;
@end

@implementation NIMServer

+ (instancetype)sharedAPI
{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}


- (instancetype)init
{
    if (self = [super init])
    {
        _appKey = @"e49a01f72ab7169a0bc8824d8c53b493";      //使用应用自己的appKey
        _appSecret = @"df1946d468f4";   //使用应用自己的appSecret
    }
    return self;
}


- (void)request:(NSString *)urlString
         params:(NSDictionary *)params
           type:(NSString *)typeString
{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    
    [request setHTTPMethod:@"post"];
    
    [self addHttpHeader:request];
    [self addHttpBody:request
             byParams:params];
    NSURLSessionTask *task =
    [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
        ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSError *resultError = error;
            NSDictionary *resultDict = nil;
            /*if (error == nil &&
                data &&
                [response isKindOfClass:[NSHTTPURLResponse class]] &&
                [(NSHTTPURLResponse *)response statusCode] == 200 ) {*/
            if (!error) {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                        options:0
                                        error:0];
                if ([dict isKindOfClass:[NSDictionary class]]) {
                    resultError = nil;
                    resultDict = dict;
                }
                NSLog(@"result: %@",dict);
                NSInteger resultCode = [[resultDict objectForKey:@"code"] integerValue];
                
                if (resultCode == 200) {
                    NSLog(@"code: %ld",(long)resultCode);
                    if ([typeString  isEqual: @"send"])
                        [self.delegate sendCodeFinished];
                    else
                        [self.delegate verifyCodeFinished];
                }
                else {
                    if ([typeString  isEqual: @"send"])
                        [self.delegate sendCodeFailed:error];
                    else
                        [self.delegate verifyCodeFailed:error];
                }
                /*if (resultError == nil && resultDict == nil) {
                    resultError = [NSError errorWithDomain:@"nim"
                                    code:0
                                    userInfo:nil];*/
            }
            else {
                if ([typeString  isEqual: @"send"])
                    [self.delegate sendCodeFailed:error];
                else
                    [self.delegate verifyCodeFailed:error];
            }
    }];
    [task resume];
}

- (void)addHttpHeader:(NSMutableURLRequest *)request
{
    [request addValue:_appKey forHTTPHeaderField:@"AppKey"];
    
    NSString *nonce = [NSString stringWithFormat:@"%zd",arc4random()];
    [request addValue:nonce forHTTPHeaderField:@"Nonce"];
    
    NSString *curTime = [NSString stringWithFormat:@"%zd",(NSInteger)[[NSDate date] timeIntervalSince1970]];
    [request addValue:curTime forHTTPHeaderField:@"CurTime"];
    
    NSString *checkSum = [[NSString stringWithFormat:@"%@%@%@",_appSecret,nonce,curTime] nim_sha1];
    [request addValue:checkSum forHTTPHeaderField:@"CheckSum"];

    
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
}

- (void)addHttpBody:(NSMutableURLRequest *)request
           byParams:(NSDictionary *)params
{
    NSMutableArray *items = [NSMutableArray array];
    for (NSString *key in params.allKeys)
    {
        [items addObject:[NSString stringWithFormat:@"%@=%@",key,params[key]]];
    }
    NSString *postBody = [items componentsJoinedByString:@"&"];
    [request setHTTPBody:[postBody dataUsingEncoding:NSUTF8StringEncoding]];
}

//发送短信验证码
- (void) send:(NSString *) phoneNum {
    //NSNumber *tempId = [NSNumber numberWithInt:3043075];tempId,@"templateid",
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:phoneNum,@"mobile", nil];
    NSString *url = @"https://api.netease.im/sms/sendcode.action";
    [self request:url params:param type:@"send"];
}
//验证短信验证码
- (void) verify:(NSString *) phoneNum
         byCode:(NSString *) verifyCode {
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:phoneNum,@"mobile",verifyCode,@"code", nil];
    NSString *url = @"https://api.netease.im/sms/verifycode.action";
    [self request:url params:param type:@"verify"];
}
@end



