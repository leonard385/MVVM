//
//  AuthenticationCoordinator.h
//  FlickrSearchMVVMC
//
//  Created by niwanglong on 2018/5/9.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Coordinator.h"
@class AuthenticationCoordinator;
@protocol AutCoordinatorDelegate<NSObject>
-(void)AuthenticationCoordinator:(AuthenticationCoordinator *)coordinate Login:(id)userInfo;
-(void)AuthenticationCoordinatorCancel:(AuthenticationCoordinator *)coordinate;
@end
@interface AuthenticationCoordinator : NSObject<Coordinator>
- (instancetype)initWithWindow:(UIWindow *)window;
- (instancetype)initWithController:(UIViewController *)controller;
@property(nonatomic,weak) id <AutCoordinatorDelegate>delegate;
@end
