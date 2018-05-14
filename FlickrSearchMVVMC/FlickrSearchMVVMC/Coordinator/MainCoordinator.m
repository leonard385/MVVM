//
//  MainCoordinator.m
//  FlickrSearchMVVMC
//
//  Created by niwanglong on 2018/5/9.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import "MainCoordinator.h"
#import "RWTFlickrSearchViewModel.h"
#import "RWTFlickrSearchViewController.h"
#import "RWTFlickrSearchResults.h"
#import "RWTFlickrPhotoMetadata.h"
#import "RWTSearchResultsViewModel.h"
#import "RWTSearchResultsViewController.h"
#import "RTWResultDetailViewModel.h"
#import "RTWResultDetailViewController.h"
#import "AuthenticationCoordinator.h"

@interface MainCoordinator()<RWTFlickrSearchViewModelDelegate,RWTSearchResultsViewModelDelegate,RTWResultDetailViewModelDelegate,AutCoordinatorDelegate>
@property (nonatomic,strong)UIWindow *window;
@property (nonatomic,strong) UINavigationController *navigationController;

@property (nonatomic,strong) NSMutableArray *subCoordinators;
@end
@implementation MainCoordinator
- (NSMutableArray *)subCoordinators{
    if(_subCoordinators == nil){
        _subCoordinators = [NSMutableArray new];
    }
    return _subCoordinators;
}

- (UINavigationController *)navigationController{
    if(_navigationController == nil){
        _navigationController = [[UINavigationController alloc]init];
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

- (void)addSubCoordinator:(id)coordinate{
    [self.subCoordinators addObject:coordinate];
}

- (void)removeCoordinator:(id)coordinate{
    if([self.subCoordinators containsObject:coordinate]){
        [self.subCoordinators removeObject:coordinate];
    }
}

#pragma mark - actions
- (void)start{
    RWTFlickrSearchViewModel *viewModel = [[RWTFlickrSearchViewModel alloc]init];
    RWTFlickrSearchViewController *mainVc = [[RWTFlickrSearchViewController alloc] initWithNibName:@"RWTFlickrSearchViewController" bundle:nil];
    mainVc.viewModel = viewModel;
    viewModel.delegate = self;
    self.navigationController.viewControllers = @[mainVc];
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
}

- (void)showResultScence:(RWTFlickrSearchResults *)result{
    RWTSearchResultsViewModel *viewModel = [[RWTSearchResultsViewModel alloc]initWithResult:result];
    viewModel.delegate = self;
    RWTSearchResultsViewController *resultVc = [[RWTSearchResultsViewController alloc]initWithNibName:@"RWTSearchResultsViewController" bundle:nil];
    resultVc.viewModel = viewModel;
    [self.navigationController pushViewController:resultVc animated:YES];
}

- (void)showDetailScence:(RWTFlickrPhoto *)photo{
    RTWResultDetailViewModel *viewModel = [[RTWResultDetailViewModel alloc]initWithModel:photo];
    viewModel.delegate = self;
    RTWResultDetailViewController *detailVc = [[RTWResultDetailViewController alloc] init];
    detailVc.viewModel = viewModel;
    [self.navigationController pushViewController:detailVc animated:YES];
}

#pragma mark - coordinateDelegate
- (void)searchCompleteWithResult:(__kindof RWTFlickrSearchResults *)result{
    [self showResultScence:result];
}

- (void)searchNeedLogin{
    AuthenticationCoordinator *authCoor = [[AuthenticationCoordinator alloc]initWithController:self.navigationController];
    authCoor.delegate = self;
    [authCoor start];
    [self addSubCoordinator:authCoor];
}

- (void)RWTSearchResultsViewDidSelectItem:(RWTFlickrPhoto *)item{
    [self showDetailScence:item];
}

- (void)detailViewModeDeleteItem:(RWTFlickrPhoto *)photo{
    [self.navigationController popViewControllerAnimated:YES];
    RWTSearchResultsViewController *Vc = self.navigationController.viewControllers.lastObject;
    RWTSearchResultsViewModel *viewModel = Vc.viewModel;
    [viewModel deleteItem:photo];
}


-(void)AuthenticationCoordinator:(AuthenticationCoordinator *)coordinate Login:(id)userInfo{
    
}

-(void)AuthenticationCoordinatorCancel:(AuthenticationCoordinator *)coordinate{
    
}

@end
