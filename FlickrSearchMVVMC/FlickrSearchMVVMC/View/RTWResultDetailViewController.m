//
//  RTWResultDetailViewController.m
//  FlickrSearchMVVMC
//
//  Created by niwanglong on 2018/5/10.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import "RTWResultDetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface RTWResultDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageViewPreview;
@property (nonatomic,strong) UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeigth;
@end

@implementation RTWResultDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpNavItems];
    [self dataBind];
}

- (void)setUpNavItems{
    UIButton *rightBtn = [UIButton new];
    [rightBtn setTitle:@"删除" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    _rightBtn = rightBtn;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)dataBind{
    RAC(self,title) = RACObserve(self.viewModel, title);
    [RACObserve(self.viewModel, photoUrl) subscribeNext:^(NSURL*  _Nullable url) {
        [self.imageViewPreview sd_setImageWithURL:url completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            CGSize imageSize = image.size;
            CGFloat imageViewH = self.imageViewPreview.bounds.size.width /( imageSize.width / imageSize.height);
            self.imageHeigth.constant = imageViewH;
        }];
    }];
    self.rightBtn.rac_command = self.viewModel.commandDelete;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
