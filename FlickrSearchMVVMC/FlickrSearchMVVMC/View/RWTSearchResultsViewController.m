//
//  RWTSearchResultsViewController.m
//  FlickrSearchMVVMC
//
//  Created by niwanglong on 2018/5/10.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import "RWTSearchResultsViewController.h"
#import "RWTSearchResultsTableViewCell.h"
@interface RWTSearchResultsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation RWTSearchResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpSubviews];
    [self dataBind];
}

- (void)setUpSubviews{
    [self.tableView registerNib:[UINib nibWithNibName:@"RWTSearchResultsTableViewCell" bundle:nil] forCellReuseIdentifier:@"RWTSearchResultsTableViewCell"];
    self.tableView.rowHeight = 172.0f;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)dataBind{
    RAC(self,title) = RACObserve(self.viewModel,title);
    [RACObserve(self.viewModel, searchResults) subscribeNext:^(id  _Nullable x) {
        [self.tableView reloadData];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.searchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RWTSearchResultsItemViewModel *cellModel = self.viewModel.searchResults[indexPath.row];
    RWTSearchResultsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RWTSearchResultsTableViewCell"];
    if(cell == nil){
        cell = [[NSBundle mainBundle]loadNibNamed:@"RWTSearchResultsTableViewCell" owner:nil options:nil].firstObject;
    }
    [cell bindViewModel:cellModel];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.viewModel.commandCellDidSelect execute:@(indexPath.row)]; 
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSArray *cells = [self.tableView visibleCells];
    for (RWTSearchResultsTableViewCell *cell in cells) {
        CGFloat value = -40 + (cell.frame.origin.y - self.tableView.contentOffset.y) / 5;
        [cell setParallax:value];
    }
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
