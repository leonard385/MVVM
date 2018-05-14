//
//  MainCoordinator.h
//  FlickrSearchMVVMC
//
//  Created by niwanglong on 2018/5/9.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Coordinator.h"
@protocol MainCoordinatorDelegate<NSObject>

@end
@interface MainCoordinator : NSObject <Coordinator>
- (instancetype)initWithWindow:(UIWindow *)window;

@property (nonatomic,weak)id<MainCoordinatorDelegate>delegate;
@end
