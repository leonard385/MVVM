//
//  RWTFlickrSearchViewController.m
//  FlickrSearchMVVMC
//
//  Created by leo on 2018/5/8.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import "RWTFlickrSearchViewController.h"

@interface RWTFlickrSearchViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *textfiledSearch;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;
@property (weak, nonatomic) IBOutlet UIButton *btnSearch;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@end

@implementation RWTFlickrSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpSubviews];
    [self bindData];
}

- (void)setUpSubviews{
    [self.loadingView startAnimating];
}

- (void)bindData{
    RAC(self,title) = RACObserve(self.viewModel, navTitle);
    RAC(self.viewModel,searchKey) = self.textfiledSearch.rac_textSignal;
    RAC(self.loadingView,hidden) = [self.viewModel.searchCommand.executing not];
    RAC(self.textfiledSearch,textColor) = RACObserve(self.viewModel, textColor);
    self.btnSearch.rac_command = self.viewModel.searchCommand;
    self.btnLogin.rac_command = self.viewModel.loginCommand;
    
    [self.viewModel.errorSignal subscribeNext:^(NSError*  _Nullable error) {
        NSString *msg = error.localizedFailureReason;
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [UITableViewCell new];
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
