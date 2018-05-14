//
//  RTWRegistViewController.m
//  FlickrSearchMVVMC
//
//  Created by niwanglong on 2018/5/9.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import "RTWRegistViewController.h"

@interface RTWRegistViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textfieldPhone;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;

@end

@implementation RTWRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpSubviews];
    [self dataBind];
}

- (void)setUpSubviews{
    [self.btnNext setBackgroundColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnNext setBackgroundColor:[UIColor grayColor] forState:UIControlStateDisabled];
    self.btnNext.layer.cornerRadius = 20.0f;
    self.btnNext.layer.masksToBounds = YES;
}

- (void)dataBind{
    RAC(self.viewModel,phone) = self.textfieldPhone.rac_textSignal;
    RAC(self.textfieldPhone,textColor) = RACObserve(self.viewModel, textColor);
    self.btnNext.rac_command = self.viewModel.commandNext;
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
