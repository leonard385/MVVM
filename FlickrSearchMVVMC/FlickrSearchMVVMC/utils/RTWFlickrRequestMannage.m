//
//  RTWFlickrRequestMannage.m
//  FlickrSearchMVVMC
//
//  Created by niwanglong on 2018/5/11.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import "RTWFlickrRequestMannage.h"
#import <objectiveflickr/ObjectiveFlickr.h>
@interface RTWFlickrRequestMannage()<OFFlickrAPIRequestDelegate>
@property (nonatomic,strong) OFFlickrAPIContext *flickrContext;
@property (nonatomic,strong) NSMutableSet <OFFlickrAPIRequest *> *requests;
@end
@implementation RTWFlickrRequestMannage

+ (instancetype)shareMannage{
    static RTWFlickrRequestMannage *mannager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mannager = [[self class] new];
    });
    return mannager;
}

- (OFFlickrAPIContext *)flickrContext{
    if(_flickrContext == nil){
        NSString *OFSampleAppAPIKey = @"9d1bdbde083bc30ebe168a64aac50be5";
        NSString *OFSampleAppAPISharedSecret = @"5fbfa610234c6c23";
        _flickrContext = [[OFFlickrAPIContext alloc] initWithAPIKey:OFSampleAppAPIKey sharedSecret:OFSampleAppAPISharedSecret];
    }
    return _flickrContext;
}

- (RACSignal *)signalFromAPIMethod:(NSString *)method
                         arguments:(NSDictionary *)args
                         transform:(id (^)(NSDictionary *response))block {
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        OFFlickrAPIRequest *flickrRequest = [[OFFlickrAPIRequest alloc] initWithAPIContext:self.flickrContext];
        flickrRequest.delegate = self;
        [self.requests addObject:flickrRequest];
        
        RACSignal *successSignal = [self rac_signalForSelector:@selector(flickrAPIRequest:didCompleteWithResponse:) fromProtocol:@protocol(OFFlickrAPIRequestDelegate)];
        
        RACSignal *errorSignal = [self rac_signalForSelector:@selector(flickrAPIRequest:didFailWithError:) fromProtocol:@protocol(OFFlickrAPIRequestDelegate)];
        
        @weakify(flickrRequest);
        [[[[successSignal
            filter:^BOOL(RACTuple  * _Nullable tuple) {//这里的first second和对应的代理函数返回一致
                @strongify(flickrRequest);
                return (tuple.first == flickrRequest);//请求匹配
            }]
           map:^id _Nullable(RACTuple*  _Nullable tuple) {
               return tuple.second;//获取请求数据
           }]
          map:block]
         subscribeNext:^(id  _Nullable data) {
             [subscriber sendNext:data];
             [subscriber sendCompleted];
         }];
        
        [errorSignal subscribeNext:^(RACTuple*  _Nullable tuple) {
            [subscriber sendError:tuple.second];
        }];
        
        [flickrRequest callAPIMethodWithGET:method
                                  arguments:args];
        return [RACDisposable disposableWithBlock:^{
            [self.requests removeObject:flickrRequest];
        }];
    }];
}

- (NSURL *)photoSourceURLFromDictionary:(NSDictionary *)inDictionary size:(NSString *)inSizeModifier{
    return [self.flickrContext photoSourceURLFromDictionary:inDictionary size:inSizeModifier];
}

@end
