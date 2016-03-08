//
//  TripstersAutoTableViewController.m
//  TripstersSDKDemo
//
//  Created by TimTiger on 16/2/24.
//  Copyright © 2016年 Tripsters. All rights reserved.
//

#import "TripstersAutoTableViewController.h"
#import "UIViewController+Extension.h"
#import "EGOTableView.h"
#import "QPSApi.h"
#import "Macro.h"
#import "UIImageView+WebCache.h"
#import "NSArray+Extension.h"

@interface TripstersAutoTableViewController ()

@end

@implementation TripstersAutoTableViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initView];
    [self reloadData];
}

- (void)initData {
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
}

- (void)initView {

    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64);
    
    _tableView = [[EGOTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 45, 0);
    self.tableView.egoDelegate = self;
    [self.view addSubview:self.tableView];
    
    UILabel *emptyLabel =  [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    emptyLabel.backgroundColor = [UIColor clearColor];
    emptyLabel.font = [UIFont systemFontOfSize:14.0f];
    emptyLabel.textColor = [UIColor blackColor];
    emptyLabel.textAlignment = NSTextAlignmentCenter;
    emptyLabel.text = @"暂无数据";
    self.tableView.emptyView = emptyLabel;
}

- (void)reloadData {
    [self.tableView loadData];
}

- (void)requestData {
}

- (void)refreshDataWithArray:(NSArray *)array {
    if (self.tableView.page == 1) {
        [self.dataArray removeAllObjects];
    }
    
    NSInteger lastPageCount = 0;
    if ([NSArray hasContent:array]) {
        lastPageCount = array.count;
        [self.dataArray addObjectsFromArray:array];
    }
    [self.tableView endLoadWithAllCount:self.dataArray.count lastPageCount:lastPageCount];
}

#pragma mark - Delegate
//MARK: - DataSource and Delgate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.tableView.egoheaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.tableView.egoheaderView egoRefreshScrollViewDidScroll:scrollView];
}

-(void)tableViewDidTriggerRefresh:(EGOTableView *)tableView {
    [self requestData];
}

-(void)tableViewDidTriggerLoadMore:(EGOTableView *)tableView {
    [self requestData];
}

@end
