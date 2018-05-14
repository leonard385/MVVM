//
//  RWTLogImpl.h
//  FlickrSearchMVVMC
//
//  Created by niwanglong on 2018/5/9.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RWTAuthenticationImpl : NSObject
+ (RACSignal *)loginWithAccount:(NSString *)acount Pass:(NSString *)pass;
+ (RACSignal *)requestSmsWithPhone:(NSString *)phone;
+ (RACSignal *)registNewUser:(NSString *)phone SMSCode:(NSString *)sms;
+ (RACSignal *)modifyPassWord:(NSString *)oldPass NewPass:(NSString *)newPass;
@end
