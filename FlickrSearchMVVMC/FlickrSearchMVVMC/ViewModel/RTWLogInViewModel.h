//
//  RTWLogInViewModel.h
//  FlickrSearchMVVMC
//
//  Created by niwanglong on 2018/5/9.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RTWLogInViewModelDelegate <NSObject>
- (void)RTWLogInViewModelDidCancel;
- (void)RTWLogInViewModelDidLogin:(id)userInfo;
- (void)RTWLogInViewModelRegistAction;
- (void)RTWLogInViewModelForgetAction;
@end

@interface RTWLogInViewModel : NSObject
@property (nonatomic,copy) NSString *account;
@property (nonatomic,copy) NSString *passWord;
@property (nonatomic,assign) BOOL hiddenCloseBtn;
@property (nonatomic,strong) UIColor *accountTextColor;
@property (nonatomic,strong) UIColor *passworldTextColor;
@property (nonatomic,assign) BOOL isAgree;
@property (nonatomic,strong) RACCommand *cancelCommand;
@property (nonatomic,strong) RACCommand *loginCommand;
@property (nonatomic,strong) RACCommand *forgetCommand;
@property (nonatomic,strong) RACCommand *registCommand;
@property (nonatomic,strong) RACCommand *agreeCommand;
@property (nonatomic,weak)id <RTWLogInViewModelDelegate>delegate;
@end
