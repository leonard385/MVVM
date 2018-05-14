//
//  AuthenticationCoordinator.m
//  FlickrSearchMVVMC
//
//  Created by niwanglong on 2018/5/9.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import "AuthenticationCoordinator.h"
#import "RTWLogInViewModel.h"
#import "RTWLogInViewController.h"
#import "RTWRegistViewModel.h"
#import "RTWRegistViewController.h"
#import "RTWVerifyViewModel.h"
#import "RTWVerifyViewController.h"
#import "RTWForgetViewModel.h"
#import "RTWForgetPSWController.h"
@interface AuthenticationCoordinator()<RTWLogInViewModelDelegate,RTWRegistViewModelDelegate,RTWVerifyDelegate,RTWForgetViewModelDelegate>
@property (nonatomic,strong) UIWindow *window;
@property (nonatomic,strong) UIViewController *superViewController;

@property (nonatomic,strong) UINavigationController *navigationController;
@end
@implementation AuthenticationCoordinator
- (UINavigationController *)navigationController{
    if(_navigationController == nil){
        _navigationController = [[UINavigationController alloc]init];
        [_navigationController setNavigationBarHidden:YES];
    }
    return _navigationController;
}

- (instancetype)initWithWindow:(UIWindow *)window{
    self = [super init];
    if (self) {
        _window = window;
    }
    return self;
}

- (instancetype)initWithController:(UIViewController *)controller{
    self = [super init];
    if (self) {
        _superViewController = controller;
    }
    return self;
}

#pragma mark - action

- (void)start{
    if(_window){
        RTWLogInViewModel *viewModel = [[RTWLogInViewModel alloc]init];
        RTWLogInViewController *logInVc = [[RTWLogInViewController alloc] initWithNibName:@"RTWLogInViewController" bundle:nil];
        logInVc.viewModel = viewModel;
        viewModel.delegate = self;
        self.navigationController.viewControllers = @[logInVc];
        self.window.rootViewController = self.navigationController;
        [self.window makeKeyAndVisible];
    }else if(_superViewController){
        RTWLogInViewModel *viewModel = [[RTWLogInViewModel alloc]init];
        viewModel.hiddenCloseBtn = NO;
        RTWLogInViewController *logInVc = [[RTWLogInViewController alloc] initWithNibName:@"RTWLogInViewController" bundle:nil];
        logInVc.viewModel = viewModel;
        viewModel.delegate = self;
        self.navigationController.viewControllers = @[logInVc];
        [self.superViewController presentViewController:self.navigationController animated:YES completion:nil];
    }
}

- (void)showRegistSence{
    RTWRegistViewModel *viewModel = [[RTWRegistViewModel alloc] init];
    RTWRegistViewController *vc = [[RTWRegistViewController alloc]initWithNibName:@"RTWRegistViewController" bundle:nil];
    vc.viewModel = viewModel;
    viewModel.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showSmsSence:(NSString *)phone{
    RTWVerifyViewModel *viewModel = [[RTWVerifyViewModel alloc]init];
    RTWVerifyViewController *vc = [[RTWVerifyViewController alloc]initWithNibName:@"RTWVerifyViewController" bundle:nil];
    viewModel.phone = phone;
    vc.viewModel = viewModel;
    viewModel.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showForgetScence{
    RTWForgetViewModel *viewModel = [RTWForgetViewModel new];
    viewModel.delegate = self;
    RTWForgetPSWController *forgetVc = [[RTWForgetPSWController alloc]initWithNibName:@"RTWForgetPSWController" bundle:nil];
    forgetVc.viewModel = viewModel;
    [self.navigationController pushViewController:forgetVc animated:YES];
}

#pragma mark - coordinateDelegate
- (void)RTWLogInViewModelDidCancel{
    if(_superViewController){
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
    [self.delegate respondsToSelector:@selector(AuthenticationCoordinatorCancel:)] ? [self.delegate AuthenticationCoordinatorCancel:self] : nil;
}

- (void)RTWLogInViewModelDidLogin:(id)userInfo{
    if(_superViewController){
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
    [self.delegate respondsToSelector:@selector(AuthenticationCoordinator:Login:)] ? [self.delegate AuthenticationCoordinator:self Login:userInfo] : nil;
}

- (void)RTWLogInViewModelRegistAction{
    [self showRegistSence];
}

- (void)RTWLogInViewModelForgetAction{
    [self showForgetScence];
}

- (void)RegistViewDoNext:(NSString *)phone{
    [self showSmsSence:phone];
}

- (void)RTWRegistComplte:(id)userInfo{
    RTWLogInViewController *rootVC = self.navigationController.viewControllers.firstObject;
    RTWLogInViewModel *viewModel = rootVC.viewModel;
    viewModel.account = userInfo[@"account"];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)modifyPassWordDone:(NSString *)passNew{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
