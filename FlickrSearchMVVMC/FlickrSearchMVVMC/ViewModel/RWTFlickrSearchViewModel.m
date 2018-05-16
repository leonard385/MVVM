//
//  RWTFlickrSearchViewModel.m
//  FlickrSearchMVVMC
//
//  Created by leo on 2018/5/8.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import "RWTFlickrSearchViewModel.h"
#import "RWTFlickrSearchImpl.h"
@interface RWTFlickrSearchViewModel()

@end

@implementation RWTFlickrSearchViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize{
    self.navTitle = @"search";
    RACSignal *searchEnableSignal =
    [[[RACObserve(self, searchKey)
    map:^id _Nullable(NSString*  _Nullable text) {
        return @(text.length > 1);
    }]
    skip:1]
    distinctUntilChanged];
    
    [searchEnableSignal subscribeNext:^(NSNumber*  _Nullable valid) {
        UIColor *textColor = [valid boolValue] ? [UIColor blackColor] : [UIColor redColor];
        self.textColor = textColor;
    }];
    
    self.searchCommand =
    [[RACCommand alloc]initWithEnabled:searchEnableSignal
                           signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [self excuteSearchSignal];
    }];
    
    self.loginCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        [self.delegate respondsToSelector:@selector(searchNeedLogin)] ? [self.delegate searchNeedLogin] : nil;
        return [RACSignal empty];
    }];
    
    RACSignal *errors = [RACSignal merge:@[self.loginCommand.errors,self.searchCommand.errors]];
    self.errorSignal = errors;
}

- (RACSignal *)excuteSearchSignal{
    [SVProgressHUD show];
    return [[[RWTFlickrSearchImpl flickrSearchSignal:self.searchKey]
             doNext:^(id  _Nullable data) {
                 [SVProgressHUD dismiss];
                 [self.delegate respondsToSelector:@selector(searchCompleteWithResult:)] ? [self.delegate searchCompleteWithResult:data] : nil;
             }]
             doError:^(NSError * _Nonnull error) {
                 [SVProgressHUD showErrorWithStatus:error.localizedFailureReason];
             }];
}
@end
