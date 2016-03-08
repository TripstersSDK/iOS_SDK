//
//  EGOTableView.h
//  TripstersSDKDemo
//
//  Created by TimTiger on 16/2/20.
//  Copyright © 2016年 Tripsters. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"

/**
 * TableView 状态
 */
typedef NS_ENUM(NSInteger,EGOTableViewStatus) {
    CanLoadMore = 0,  //还有更多数据
    Empty = 1,              //没有数据
    NoMore = 2,          //没有更多数据了
};

@protocol EGOTableViewDelegate;

@interface EGOTableView : UITableView

@property (nonatomic,weak) id <EGOTableViewDelegate> egoDelegate;
@property (nonatomic,readwrite) NSInteger page;
@property (nonatomic,readwrite) BOOL showRefresh;
@property (nonatomic,readwrite) BOOL showLoadMore;
@property (nonatomic,strong) EGORefreshTableHeaderView *egoheaderView;
@property (nonatomic,strong) UIView *emptyView;
@property (nonatomic,strong) UIView *emptyBackgroundView;

- (void)loadData;
- (void)endLoadWithAllCount:(NSInteger)allCount lastPageCount:(NSInteger)pageCount;

@end

@protocol EGOTableViewDelegate <UITableViewDelegate,UITableViewDataSource>
-(void)tableViewDidTriggerRefresh:(EGOTableView *)tableView;
-(void)tableViewDidTriggerLoadMore:(EGOTableView *)tableView;
@end