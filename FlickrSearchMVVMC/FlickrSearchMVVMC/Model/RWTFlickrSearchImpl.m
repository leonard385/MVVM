//
//  RWTFlickrSearchImpl.m
//  FlickrSearchMVVMC
//
//  Created by leo on 2018/5/8.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import "RWTFlickrSearchImpl.h"
#import <LinqToObjectiveC/NSArray+LinqExtensions.h>
#import "RWTFlickrSearchResults.h"
#import "RWTFlickrPhoto.h"
#import "RWTFlickrPhotoMetadata.h"
#import "RTWFlickrRequestMannage.h"
@interface RWTFlickrSearchImpl()

@end

@implementation RWTFlickrSearchImpl

+ (RACSignal *)flickrSearchSignal:(NSString *)searchString{
    return [[[RTWFlickrRequestMannage shareMannage] signalFromAPIMethod:@"flickr.photos.search"
                            arguments:@{@"text": searchString,
                                        @"sort": @"interestingness-desc"}
                            transform:^id(NSDictionary *response) {
                                NSDictionary *photosDic = response[@"photos"];
                                NSArray *photoArray = photosDic[@"photo"];
                                NSNumber *totalNum = photosDic[@"total"];
                                RWTFlickrSearchResults *results = [RWTFlickrSearchResults new];
                                results.searchString = searchString;
                                results.totalResults = [totalNum integerValue];
                                
                                NSArray *photos = [photoArray linq_select:^id(NSDictionary* jsonPhoto) {
                                    RWTFlickrPhoto *photo = [RWTFlickrPhoto new];
                                    photo.title = jsonPhoto[@"title"];
                                    photo.photoID = jsonPhoto[@"id"];
                                    photo.url = [[RTWFlickrRequestMannage shareMannage] photoSourceURLFromDictionary:jsonPhoto size:OFFlickrMediumSize];
                                    return photo;
                                }];
                                results.photos = photos;
                                return results;
                            }]logAll];
}

+ (RACSignal *)flickrImageMetadata:(NSString *)photoId {
    
    RACSignal *favourites = [[RTWFlickrRequestMannage shareMannage] signalFromAPIMethod:@"flickr.photos.getFavorites"
                                            arguments:@{@"photo_id": photoId}
                                            transform:^id(NSDictionary *response) {
                                                NSString *total = [response valueForKeyPath:@"photo.total"];
                                                return total;
                                            }];
    
    RACSignal *comments = [[RTWFlickrRequestMannage shareMannage] signalFromAPIMethod:@"flickr.photos.getInfo"
                                          arguments:@{@"photo_id": photoId}
                                          transform:^id(NSDictionary *response) {
                                              NSString *total = [response valueForKeyPath:@"photo.comments._text"];
                                              return total;
                                          }];
    
    return [[RACSignal combineLatest:@[favourites, comments] reduce:^id(NSString *favs, NSString *coms){
        RWTFlickrPhotoMetadata *meta = [RWTFlickrPhotoMetadata new];
        meta.comments = [coms integerValue];
        meta.favourites = [favs integerValue];
        return  meta;
    }] logAll];
}
@end
