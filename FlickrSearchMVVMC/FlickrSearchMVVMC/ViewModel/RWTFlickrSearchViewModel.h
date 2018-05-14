//
//  RWTFlickrSearchViewModel.h
//  FlickrSearchMVVMC
//
//  Created by leo on 2018/5/8.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RWTFlickrSearchResults;
@protocol RWTFlickrSearchViewModelDelegate <NSObject>
- (void)searchCompleteWithResult:(__kindof RWTFlickrSearchResults* _Nullable)result;
- (void)searchNeedLogin;
@end
@interface RWTFlickrSearchViewModel : NSObject
@property (nonatomic,copy) NSString *navTitle;
@property (nonatomic,copy) NSString *searchKey;
@property (nonatomic,strong) UIColor *textColor;
@property (nonatomic,strong) RACCommand *searchCommand;
@property (nonatomic,strong) RACCommand *loginCommand;
@property (nonatomic,strong) RACSignal *errorSignal;
@property (nonatomic,weak) id<RWTFlickrSearchViewModelDelegate>delegate;
@end
