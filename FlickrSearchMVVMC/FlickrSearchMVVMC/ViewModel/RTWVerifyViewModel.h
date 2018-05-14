//
//  RTWVerifyViewModel.h
//  FlickrSearchMVVMC
//
//  Created by niwanglong on 2018/5/9.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol RTWVerifyDelegate <NSObject>
-(void)RTWRegistComplte:(id)userInfo;
@end
@interface RTWVerifyViewModel : NSObject
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *smsCode;
@property (nonatomic,strong) UIColor *textColor;
@property (nonatomic,strong) RACCommand *commandComplete;

@property (nonatomic,weak)id<RTWVerifyDelegate> delegate;
@end
