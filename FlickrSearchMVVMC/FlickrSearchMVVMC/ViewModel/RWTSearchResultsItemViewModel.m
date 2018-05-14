//
//  RWTSearchResultsItemViewModel.m
//  FlickrSearchMVVMC
//
//  Created by niwanglong on 2018/5/10.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import "RWTSearchResultsItemViewModel.h"
#import "RWTFlickrPhotoMetadata.h"
#import "RWTFlickrSearchImpl.h"
@interface RWTSearchResultsItemViewModel()
@end
@implementation RWTSearchResultsItemViewModel
- (instancetype)initWithModel:(RWTFlickrPhoto *)photo{
    self = [super init];
    if (self) {
        _photoID = photo.photoID;
        _title = photo.title;
        _url = photo.url;
        _photo = photo;
        [self initialize];
    }
    return self;
}

- (void)initialize{
    RACSignal *visibleStateChanged = [RACObserve(self, isVisible) skip:1];
    RACSignal *visibleSignal = [visibleStateChanged filter:^BOOL(NSNumber*  _Nullable value) {
        return [value boolValue];
    }];
    RACSignal *hiddenSignal = [visibleStateChanged filter:^BOOL(id  _Nullable value) {
        return ![value boolValue];
    }];
    //从隐藏状态切换到出现1s后 请求数据
    RACSignal *featchMetaData = [[visibleSignal delay:1.0f] takeUntil:hiddenSignal];
    @weakify(self);
    [featchMetaData subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [[RWTFlickrSearchImpl flickrImageMetadata:self.photo.photoID] subscribeNext:^(RWTFlickrPhotoMetadata*  _Nullable model) {
            self.favourites = @(model.favourites);
            self.comments = @(model.comments);
        }];
    }];
    
}

@end
