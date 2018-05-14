//
//  RWTLogImpl.m
//  FlickrSearchMVVMC
//
//  Created by niwanglong on 2018/5/9.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import "RWTAuthenticationImpl.h"

@implementation RWTAuthenticationImpl
+ (RACSignal *)loginWithAccount:(NSString *)acount Pass:(NSString *)pass{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:@{@"account":acount,@"pass":pass}];
            [subscriber sendCompleted];
        });
        return nil;
    }];
}

+ (RACSignal *)requestSmsWithPhone:(NSString *)phone{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:phone];
            [subscriber sendCompleted];
        });
        return nil;
    }];
}

+ (RACSignal *)registNewUser:(NSString *)phone SMSCode:(NSString *)sms{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:@{@"account":phone,@"smsCode":sms}];
            [subscriber sendCompleted];
        });
        return nil;
    }];
}

+ (RACSignal *)modifyPassWord:(NSString *)oldPass NewPass:(NSString *)newPass{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:newPass];
            [subscriber sendCompleted];
        });
        return nil;
    }];
}
@end
