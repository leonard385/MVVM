//
//  RWTSearchResultsViewModel.m
//  FlickrSearchMVVMC
//
//  Created by niwanglong on 2018/5/10.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import "RWTSearchResultsViewModel.h"
#import "RWTFlickrSearchResults.h"
#import <LinqToObjectiveC/LinqToObjectiveC.h>
@interface RWTSearchResultsViewModel()
@property (nonatomic,strong)RWTFlickrSearchResults *results;
@end
@implementation RWTSearchResultsViewModel
- (instancetype)initWithResult:(RWTFlickrSearchResults *)result{
    self = [super init];
    if (self) {
        _results = result;
        [self dataInit];
        [self initialize];
    }
    return self;
}

- (void)dataInit{
    self.title = _results.searchString;
    NSArray *photos = _results.photos;
    NSArray *itemViewModels = [photos linq_select:^id(RWTFlickrPhoto* itemModel) {
        RWTSearchResultsItemViewModel *viewModel = [[RWTSearchResultsItemViewModel alloc]initWithModel:itemModel];
        return viewModel;
    }];
    self.searchResults = itemViewModels;
}

- (void)initialize{
    self.commandCellDidSelect = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [self exuteSelectSignal:input];
    }];
}

- (RACSignal *)exuteSelectSignal:(NSNumber *)idx{
    RWTSearchResultsItemViewModel *itemModel = self.searchResults[idx.unsignedIntegerValue];
    RWTFlickrPhoto *photo = itemModel.photo;
    [self.delegate respondsToSelector:@selector(RWTSearchResultsViewDidSelectItem:)] ? [self.delegate RWTSearchResultsViewDidSelectItem:photo] : nil;
    return [RACSignal empty];
}

- (void)deleteItem:(RWTFlickrPhoto *)item{
    __block RWTSearchResultsItemViewModel *viewModel;
    [self.searchResults enumerateObjectsUsingBlock:^(RWTSearchResultsItemViewModel * _Nonnull itemViewModel, NSUInteger idx, BOOL * _Nonnull stop) {
        if([itemViewModel.photoID isEqualToString:item.photoID]){
            viewModel = itemViewModel;
            *stop = YES;
        }
    }];
    if(viewModel != nil){
        NSMutableArray *array = [[NSMutableArray alloc]initWithArray:self.searchResults];
        [array removeObject:viewModel];
        self.searchResults = array;
    }
}
@end
