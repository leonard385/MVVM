//
//  APPInfo.m
//  FlickrSearchMVVMC
//
//  Created by niwanglong on 2018/5/9.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import "APPInfo.h"

@implementation APPInfo
+ (instancetype)mannager{
    static APPInfo *mannage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mannage = [[self class] new];
    });
    return mannage;
}
@end
