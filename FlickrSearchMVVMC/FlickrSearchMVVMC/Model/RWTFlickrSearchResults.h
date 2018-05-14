//
//  RWTFlickrSearchResults.h
//  FlickrSearchMVVMC
//
//  Created by leo on 2018/5/8.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RWTFlickrPhoto;
@interface RWTFlickrSearchResults : NSObject
@property (copy, nonatomic) NSString *searchString;
@property (strong, nonatomic) NSArray <RWTFlickrPhoto *>*photos;
@property (nonatomic) NSUInteger totalResults;
@end
