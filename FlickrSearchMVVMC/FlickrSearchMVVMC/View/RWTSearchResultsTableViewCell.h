//
//  RWTSearchResultsTableViewCell.h
//  FlickrSearchMVVMC
//
//  Created by niwanglong on 2018/5/10.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CEReactiveView.h"
@interface RWTSearchResultsTableViewCell : UITableViewCell <CEReactiveView>


- (void) setParallax:(CGFloat)value;
@end
