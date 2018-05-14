//
//  RWTFlickrPhoto.h
//  FlickrSearchMVVMC
//
//  Created by leo on 2018/5/8.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RWTFlickrPhoto : NSObject
@property (strong, nonatomic) NSString *photoID;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSURL *url;
@end
