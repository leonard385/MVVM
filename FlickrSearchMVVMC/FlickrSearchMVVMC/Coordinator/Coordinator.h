//
//  Coordinator.h
//  FlickrSearchMVVMC
//
//  Created by niwanglong on 2018/5/9.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol Coordinator <NSObject>
- (void)start;
@optional
- (void)addSubCoordinator:(id)coordinate;
- (void)removeCoordinator:(id)coordinate;
@end
