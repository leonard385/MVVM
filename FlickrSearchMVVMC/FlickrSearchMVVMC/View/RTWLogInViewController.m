//
//  RTWLogInViewController.m
//  FlickrSearchMVVMC
//
//  Created by niwanglong on 2018/5/9.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import "RTWLogInViewController.h"

@interface RTWLogInViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textfieldAccount;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPass;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UIButton *btnForget;
@property (weak, nonatomic) IBOutlet UIButton *btnRegist;
@property (weak, nonatomic) IBOutlet UIButton *btnAgree;

@property (weak, nonatomic) IBOutlet UIButton *btnClose;

@end

@implementation RTWLogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpSubviews];
    [self dataBind];
}

- (void)setUpSubviews{
    [self.btnLogin setBackgroundColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnLogin setBackgroundColor:[UIColor grayColor] forState:UIControlStateDisabled];
    self.btnLogin.layer.cornerRadius = 20.0f;
    self.btnLogin.layer.masksToBounds = YES;
}

- (void)dataBind{
    RAC(self.btnClose,hidden) = RACObserve(self.viewModel, hiddenCloseBtn);
    RAC(self.textfieldAccount,text) = RACObserve(self.viewModel, account);
    RAC(self.textFieldPass,text) = RACObserve(self.viewModel, passWord);
    [[self.textfieldAccount rac_signalForControlEvents:UIControlEventEditingDidEnd] subscribeNext:^(__kindof UITextField * _Nullable field) {
        self.viewModel.account = field.text;
    }];
    [[self.textFieldPass rac_signalForControlEvents:UIControlEventEditingDidEnd] subscribeNext:^(__kindof UITextField * _Nullable field) {
        self.viewModel.passWord = field.text;
    }];
    RAC(self.viewModel,account) = self.textfieldAccount.rac_textSignal;
    RAC(self.viewModel,passWord) = self.textFieldPass.rac_textSignal;
    RAC(self.textfieldAccount,textColor) = RACObserve(self.viewModel, accountTextColor);
    RAC(self.textFieldPass,textColor) = RACObserve(self.viewModel, passworldTextColor);
    RAC(self.btnAgree,selected) = RACObserve(self.viewModel, isAgree);
    self.btnClose.rac_command = self.viewModel.cancelCommand;
    self.btnLogin.rac_command = self.viewModel.loginCommand;
    self.btnForget.rac_command = self.viewModel.forgetCommand;
    self.btnRegist.rac_command = self.viewModel.registCommand;
    self.btnAgree.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定协议内容" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *comfirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.viewModel.agreeCommand execute:nil];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:comfirmAction];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
        return [RACSignal empty];
    }];
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
