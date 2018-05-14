//
//  RWTSearchResultsViewModel.h
//  FlickrSearchMVVMC
//
//  Created by niwanglong on 2018/5/10.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWTFlickrSearchResults.h"
#import "RWTSearchResultsItemViewModel.h"
@protocol RWTSearchResultsViewModelDelegate<NSObject>
- (void)RWTSearchResultsViewDidSelectItem:(RWTFlickrPhoto *)item;
@end

@interface RWTSearchResultsViewModel : NSObject
- (instancetype)initWithResult:(RWTFlickrSearchResults *)result;

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSArray <RWTSearchResultsItemViewModel *>*searchResults;
@property (nonatomic,strong) RACCommand *commandCellDidSelect;
@property (nonatomic,weak) id <RWTSearchResultsViewModelDelegate>delegate;

- (void)deleteItem:(RWTFlickrPhoto *)item;
@end
