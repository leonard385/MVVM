//
//  RTWFlickrRequestMannage.h
//  FlickrSearchMVVMC
//
//  Created by niwanglong on 2018/5/11.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import "ObjectiveFlickr.h"

@interface RTWFlickrRequestMannage : OFFlickrAPIRequest
+ (instancetype)shareMannage;
- (RACSignal *)signalFromAPIMethod:(NSString *)method
                         arguments:(NSDictionary *)args
                         transform:(id (^)(NSDictionary *response))block;
- (NSURL *)photoSourceURLFromDictionary:(NSDictionary *)inDictionary size:(NSString *)inSizeModifier;
@end
