//
//  RTWResultDetailViewModel.m
//  FlickrSearchMVVMC
//
//  Created by niwanglong on 2018/5/10.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import "RTWResultDetailViewModel.h"
@interface RTWResultDetailViewModel()
@property (nonatomic,strong)RWTFlickrPhoto *photoModel;
@end
@implementation RTWResultDetailViewModel
- (instancetype)initWithModel:(RWTFlickrPhoto *)photo{
    self = [super init];
    if(self){
        _photoModel = photo;
        _title = photo.title;
        _photoUrl = photo.url;
        [self initialize];
    }
    return self;
}

- (void)initialize{
    self.commandDelete = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        [self.delegate respondsToSelector:@selector(detailViewModeDeleteItem:)] ? [self.delegate detailViewModeDeleteItem:self.photoModel] : nil;
        return [RACSignal empty];
    }];
}

@end
