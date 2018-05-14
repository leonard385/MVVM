
//
//  AppCoordinator.m
//  FlickrSearchMVVMC
//
//  Created by niwanglong on 2018/5/9.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import "AppCoordinator.h"
#import "APPInfo.h"
#import "AuthenticationCoordinator.h"
#import "MainCoordinator.h"
@interface AppCoordinator ()<AutCoordinatorDelegate,MainCoordinatorDelegate>
@property (nonatomic,strong) UIWindow *window;
@property (nonatomic,strong) NSMutableArray *coordinates;
@end
@implementation AppCoordinator

- (NSMutableArray *)coordinates{
    if(_coordinates == nil){
        _coordinates = [NSMutableArray new];
    }
    return _coordinates;
}

- (instancetype)initWithWindow:(UIWindow *)window{
    self = [super init];
    if (self) {
        _window = window;
    }
    return self;
}

- (void)addSubCoordinator:(id)coordinate{
    [self.coordinates addObject:coordinate];
}

- (void)removeCoordinator:(id)coordinate{
    if([self.coordinates containsObject:coordinate]){
        [self.coordinates removeObject:coordinate];
    }
}

- (void)start{
    BOOL hasLogIn = [APPInfo mannager].isLogIn;
    if(hasLogIn){
        [self showMainSence];
    }else{
        [self showAuthSence];
    }
}

- (void)showMainSence{
    MainCoordinator *mainCoor = [[MainCoordinator alloc]initWithWindow:self.window];
    mainCoor.delegate = self;
    [mainCoor start];
    [self addSubCoordinator:mainCoor];
}

- (void)showAuthSence{
    AuthenticationCoordinator *authCoor = [[AuthenticationCoordinator alloc]initWithWindow:self.window];
    authCoor.delegate = self;
    [self addSubCoordinator:authCoor];
    [authCoor start];
}

#pragma mark - CoodinateDelegate

-(void)AuthenticationCoordinator:(AuthenticationCoordinator *)coordinate Login:(id)userInfo{
    [APPInfo mannager].userName = userInfo[@"account"];
    [APPInfo mannager].logIn = YES;
    [self removeCoordinator:coordinate];
    [self showMainSence];
}

-(void)AuthenticationCoordinatorCancel:(AuthenticationCoordinator *)coordinate{
    [self removeCoordinator:coordinate];
    [self showMainSence];
}

@end
