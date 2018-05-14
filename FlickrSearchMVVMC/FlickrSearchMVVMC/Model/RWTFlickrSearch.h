//
//  RWTFlickrSearch.h
//  FlickrSearchMVVMC
//
//  Created by leo on 2018/5/8.
//  Copyright © 2018年 倪望龙. All rights reserved.
//
#import <Foundation/Foundation.h>
@protocol RWTFlickrSearch <NSObject>
+ (RACSignal *)flickrSearchSignal:(NSString *)searchString;
+ (RACSignal *)flickrImageMetadata:(NSString *)photoId;
@end
