//
//  RTWForgetViewModel.m
//  FlickrSearchMVVMC
//
//  Created by niwanglong on 2018/5/10.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import "RTWForgetViewModel.h"
#import "RWTAuthenticationImpl.h"
@implementation RTWForgetViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize{
    RACSignal *oldPassSignal =
    [[[RACObserve(self, passOld)
       map:^id _Nullable(NSString *  _Nullable text) {
           return @(text.length >= 6);
       }]
      skip:1]
      distinctUntilChanged];
    
    RACSignal *newPassSignal =
    [[[RACObserve(self, passNew)
     map:^id _Nullable(NSString *  _Nullable text) {
         return @(text.length >= 6);
     }]
    skip:1]
    distinctUntilChanged];
    
    RACSignal *validSignal = [RACSignal combineLatest:@[oldPassSignal,newPassSignal]
                                               reduce:^(NSNumber *oldValid,NSNumber *newValid){
                                                   return @([oldValid boolValue]&&[newValid boolValue]);
                                               }];
    
    [oldPassSignal subscribeNext:^(NSNumber*  _Nullable valid) {
        UIColor *textColor = [valid boolValue] ? [UIColor blackColor] : [UIColor redColor];
        self.textColorOld = textColor;
    }];
    
    [newPassSignal subscribeNext:^(NSNumber*  _Nullable valid) {
        UIColor *textColor = [valid boolValue] ? [UIColor blackColor] : [UIColor redColor];
        self.textColorNew = textColor;
    }];
    
    self.commandDone = [[RACCommand alloc]initWithEnabled:validSignal
                                              signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
                                                 return [self excuteModifyPass];
    }];
}

- (RACSignal *)excuteModifyPass{
    [SVProgressHUD show];
    return [[[RWTAuthenticationImpl modifyPassWord:self.passOld NewPass:self.passNew]
             doNext:^(NSString*  _Nullable newPass) {
                 [SVProgressHUD dismiss];
                 [self.delegate respondsToSelector:@selector(modifyPassWordDone:)] ? [self.delegate modifyPassWordDone:newPass] : nil;
             }]
             doError:^(NSError * _Nonnull error) {
                 [SVProgressHUD showErrorWithStatus:@"修改失败"];
             }];
}



@end
