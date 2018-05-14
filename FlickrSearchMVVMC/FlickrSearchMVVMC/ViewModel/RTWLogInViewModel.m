//
//  RTWLogInViewModel.m
//  FlickrSearchMVVMC
//
//  Created by niwanglong on 2018/5/9.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import "RTWLogInViewModel.h"
#import "RWTAuthenticationImpl.h"
@interface RTWLogInViewModel()
@end
@implementation RTWLogInViewModel
- (instancetype)init{
    self = [super init];
    if (self) {
        self.hiddenCloseBtn = YES;
        [self initialize];
    }
    return self;
}

- (void)initialize{
    RACSignal *accountValidSignal =
    [[[RACObserve(self, account)
       map:^id _Nullable(NSString *  _Nullable account) {
        return @(account.length > 3);
       }]
      skip:1]
      distinctUntilChanged];
    
    RACSignal *passValidSignal =
    [[[RACObserve(self, passWord)
      map:^id _Nullable(NSString*  _Nullable pwd) {
        return @(pwd.length > 3);
      }]
      skip:1]
      distinctUntilChanged];
    //颜色变化
    [[accountValidSignal
        map:^id _Nullable(NSNumber *  _Nullable valid) {
        BOOL isValid = [valid boolValue];
        UIColor *textColor = isValid ? [UIColor blackColor] : [UIColor redColor];
        return textColor;
        }]
        subscribeNext:^(UIColor*  _Nullable textColor) {
            self.accountTextColor = textColor;
        }];

    [[passValidSignal
      map:^id _Nullable(NSNumber *  _Nullable valid) {
          BOOL isValid = [valid boolValue];
          UIColor *textColor = isValid ? [UIColor blackColor] : [UIColor redColor];
          return textColor;
      }]
     subscribeNext:^(UIColor*  _Nullable textColor) {
         self.passworldTextColor = textColor;
     }];
    
    RACSignal *validSignal = [RACSignal combineLatest:@[accountValidSignal,passValidSignal] reduce:^(NSNumber *acValid,NSNumber*passValid){
        return @([acValid boolValue] && [passValid boolValue]);
    }];
    
    self.cancelCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        [self.delegate respondsToSelector:@selector(RTWLogInViewModelDidCancel)] ? [self.delegate RTWLogInViewModelDidCancel] : nil;
        return [RACSignal empty];
    }];
    
    self.loginCommand = [[RACCommand alloc]initWithEnabled:validSignal
                                               signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
                                                   return [self executeLoginSignal];
    }];
    
    self.forgetCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        [self.delegate respondsToSelector:@selector(RTWLogInViewModelForgetAction)] ? [self.delegate RTWLogInViewModelForgetAction] : nil;
        return [RACSignal empty];
    }];
    
    self.registCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        [self.delegate respondsToSelector:@selector(RTWLogInViewModelRegistAction)] ? [self.delegate RTWLogInViewModelRegistAction] : nil;
        return [RACSignal empty];
    }];
    
    self.agreeCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        self.isAgree = !self.isAgree;
        return [RACSignal empty];
    }];
}

-(RACSignal *)executeLoginSignal{
    [SVProgressHUD show];
    return [[[RWTAuthenticationImpl loginWithAccount:self.account Pass:self.passWord]
             doNext:^(id  _Nullable userInfo) {
                 [SVProgressHUD showSuccessWithStatus:@"登录成功"];
                 [self.delegate respondsToSelector:@selector(RTWLogInViewModelDidLogin:)] ? [self.delegate RTWLogInViewModelDidLogin:userInfo] : nil;
             }]
             doError:^(NSError * _Nonnull error) {
                 [SVProgressHUD showErrorWithStatus:@"登录失败"];
             }];
}

@end
