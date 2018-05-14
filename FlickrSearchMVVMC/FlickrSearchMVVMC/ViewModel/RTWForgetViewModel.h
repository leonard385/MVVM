//
//  RTWForgetViewModel.h
//  FlickrSearchMVVMC
//
//  Created by niwanglong on 2018/5/10.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol RTWForgetViewModelDelegate <NSObject>
- (void)modifyPassWordDone:(NSString *)passNew;
@end
@interface RTWForgetViewModel : NSObject
@property (nonatomic,copy) NSString *passOld;
@property (nonatomic,copy) NSString *passNew;
@property (nonatomic,strong) UIColor *textColorOld;
@property (nonatomic,strong) UIColor *textColorNew;
@property (nonatomic,strong) RACCommand *commandDone;
@property (nonatomic,weak)id <RTWForgetViewModelDelegate>delegate;
@end
