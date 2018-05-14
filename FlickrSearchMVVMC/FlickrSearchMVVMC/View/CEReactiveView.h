//
//  CEReactiveView.h
//  FlickrSearchMVVMC
//
//  Created by niwanglong on 2018/5/10.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol CEReactiveView <NSObject>
- (void)bindViewModel:(id)viewModel;
@end
