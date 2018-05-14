//
//  RTWVerifyViewModel.m
//  FlickrSearchMVVMC
//
//  Created by niwanglong on 2018/5/9.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import "RTWVerifyViewModel.h"
#import "RWTAuthenticationImpl.h"
@interface RTWVerifyViewModel()

@end
@implementation RTWVerifyViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize{
    RACSignal *validSignal = [RACObserve(self, smsCode) map:^id _Nullable(NSString*  _Nullable text) {
        return @(text.length >= 6);
    }];
    
    [validSignal subscribeNext:^(NSNumber*  _Nullable valid) {
        UIColor *textColor = [valid boolValue] ? [UIColor blackColor] : [UIColor redColor];
        self.textColor = textColor;
    }];
    
    self.commandComplete = [[RACCommand alloc]initWithEnabled:validSignal
                                                signalBlock:^RACSignal * _Nonnull(id  _Nullable text) {
                                                    return [self executeRegistSignal];
    }];
}

- (void)setPhoneNum:(NSString *)phone{
    _phone = phone;
}

- (RACSignal *)executeRegistSignal{
    [SVProgressHUD show];
    return [[[RWTAuthenticationImpl registNewUser:self.phone SMSCode:self.smsCode]
             doNext:^(id  _Nullable x) {
                [SVProgressHUD dismiss];
                [self.delegate respondsToSelector:@selector(RTWRegistComplte:)] ? [self.delegate RTWRegistComplte:x] : nil;
            }]
            doError:^(NSError * _Nonnull error) {
                [SVProgressHUD dismiss];
            }];
}
@end
