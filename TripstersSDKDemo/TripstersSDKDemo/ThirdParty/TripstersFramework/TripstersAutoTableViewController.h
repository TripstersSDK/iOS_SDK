//
//  TripstersAutoTableViewController.h
//  TripstersSDKDemo
//
//  Created by TimTiger on 16/2/24.
//  Copyright © 2016年 Tripsters. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOTableView.h"
#import "UIViewController+Extension.h"

@interface TripstersAutoTableViewController : UIViewController <EGOTableViewDelegate>

@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,readonly) EGOTableView *tableView;

//Life Cycle
- (void)initData;
- (void)initView;
- (void)reloadData;

//走接口获取数据
- (void)requestData;

//接口返回数据后 刷新列表
- (void)refreshDataWithArray:(NSArray *)array;

//
-(void)tableViewDidTriggerRefresh:(EGOTableView *)tableView;
-(void)tableViewDidTriggerLoadMore:(EGOTableView *)tableView;

@end
