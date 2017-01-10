//
//  NIMServerAPI.h
//  ObjcServerAPI
//
//  Created by amao on 2/26/16.
//  Copyright © 2016 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NIMServerDelegate.h"

typedef void(^NIMServerResultBlock)(NSError *error,NSDictionary *resultDict);

@interface NIMServer : NSObject

@property (weak, nonatomic) id <NIMServerDelegate> delegate;

+ (instancetype)sharedAPI;

- (void)request:(NSString *)urlString
         params:(NSDictionary *)params
           type:(NSString *) typeString;

- (void) send:(NSString *) phoneNum;

- (void) verify:(NSString *) phoneNum
         byCode:(NSString *) verifyCode;
@end
