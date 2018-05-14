//
//  RWTSearchResultsItemViewModel.h
//  FlickrSearchMVVMC
//
//  Created by niwanglong on 2018/5/10.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWTFlickrPhoto.h"
@interface RWTSearchResultsItemViewModel : NSObject
- (instancetype)initWithModel:(RWTFlickrPhoto *)photo;
@property (strong, nonatomic) RWTFlickrPhoto *photo;

@property (nonatomic) BOOL isVisible;
@property (nonatomic,strong)  NSString *photoID;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic) NSNumber *favourites;
@property (strong, nonatomic) NSNumber *comments;

@end
