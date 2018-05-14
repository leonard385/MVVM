//
//  APPInfo.h
//  FlickrSearchMVVMC
//
//  Created by niwanglong on 2018/5/9.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APPInfo : NSObject
+(instancetype)mannager;
//是否已经登录
@property (nonatomic,assign,getter = isLogIn)BOOL logIn;
//用户名
@property (nonatomic,copy) NSString *userName;
@end
