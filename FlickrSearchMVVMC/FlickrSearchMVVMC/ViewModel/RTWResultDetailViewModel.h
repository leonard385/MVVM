//
//  RTWResultDetailViewModel.h
//  FlickrSearchMVVMC
//
//  Created by niwanglong on 2018/5/10.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWTFlickrPhoto.h"
@protocol RTWResultDetailViewModelDelegate <NSObject>
- (void)detailViewModeDeleteItem:(RWTFlickrPhoto *)photo;
@end
@interface RTWResultDetailViewModel : NSObject
- (instancetype)initWithModel:(RWTFlickrPhoto *)photo;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,strong) NSURL *photoUrl;
@property (nonatomic,strong) RACCommand *commandDelete;

@property (nonatomic,weak)id <RTWResultDetailViewModelDelegate>delegate;
@end
