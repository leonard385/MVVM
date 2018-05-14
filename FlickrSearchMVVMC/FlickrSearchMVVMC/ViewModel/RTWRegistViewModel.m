//
//  RTWRegistViewModel.m
//  FlickrSearchMVVMC
//
//  Created by niwanglong on 2018/5/9.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import "RTWRegistViewModel.h"
#import "RWTAuthenticationImpl.h"
@interface RTWRegistViewModel()

@end
@implementation RTWRegistViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize{
    RACSignal *phoneValid = [RACObserve(self, phone) map:^id _Nullable(NSString*  _Nullable text) {
        return @(text.length > 3);
    }];
    
    [[phoneValid map:^id _Nullable(NSNumber*  _Nullable value) {
        UIColor *textColor = [value boolValue] ? [UIColor blackColor] : [UIColor redColor];
        return textColor;
    }]subscribeNext:^(UIColor*  _Nullable color) {
        self.textColor = color;
    }];
    
    self.commandNext = [[RACCommand alloc]initWithEnabled:phoneValid
                                              signalBlock:^RACSignal * _Nonnull(NSString*  _Nullable text) {
                                                  return [self excuteRegistSignal];
    }];
}

- (RACSignal *)excuteRegistSignal{
    [SVProgressHUD show];
    return [[[RWTAuthenticationImpl requestSmsWithPhone:self.phone]
             doNext:^(NSString*  _Nullable account) {
                 [SVProgressHUD dismiss];
                 [self.delegate respondsToSelector:@selector(RegistViewDoNext:)] ? [self.delegate RegistViewDoNext:account] : nil;
             }]
            doError:^(NSError * _Nonnull error) {
                [SVProgressHUD dismiss];
            }];
}
@end
