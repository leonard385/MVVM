//
//  RTWRegistViewModel.h
//  FlickrSearchMVVMC
//
//  Created by niwanglong on 2018/5/9.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol RTWRegistViewModelDelegate <NSObject>
- (void)RegistViewDoNext:(NSString *)phone;
@end
@interface RTWRegistViewModel : NSObject
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,strong) UIColor *textColor;
@property (nonatomic,strong) RACCommand *commandNext;

@property (nonatomic,weak) id<RTWRegistViewModelDelegate> delegate;
@end
