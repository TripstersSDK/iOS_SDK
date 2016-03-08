//
//  EGOTableView.m
//  TripstersSDKDemo
//
//  Created by TimTiger on 16/2/20.
//  Copyright © 2016年 Tripsters. All rights reserved.
//

#import "EGOTableView.h"
#import "EGORefreshTableHeaderView.h"
#import "EGOLoadMoreFootView.h"

@interface EGOTableView () <EGORefreshTableHeaderDelegate,EGOLoadMoreFootViewDelegate>

@property (nonatomic,strong) EGOLoadMoreFootView *loadMoreView;
@property (nonatomic,readwrite) BOOL isLoading;

@end

@implementation EGOTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)dealloc
{
    if (self.loadMoreView != nil) {
        [self removeObserver:self.loadMoreView forKeyPath:@"contentOffset"];
    }
    self.loadMoreView = nil;
}

#pragma mark - Private Api
- (void)setupView {
    self.page = 1;
    self.isLoading = NO;
    self.showRefresh = YES;
    self.showLoadMore = YES;
    
    self.egoheaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0-self.bounds.size.height, self.frame.size.width, self.bounds.size.height)];
    self.egoheaderView.delegate = self;
    [self addSubview:self.egoheaderView];
    
    self.loadMoreView = [[EGOLoadMoreFootView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 40)];
    [self addObserver:self.loadMoreView forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    self.loadMoreView.remindStrArray = @[NSLocalizedStringFromTable(@"Load More", @"DemoLocalizable", @"Load More"),
                                                                NSLocalizedStringFromTable(@"Loading...", @"DemoLocalizable", @"Loading..."),
                                                                NSLocalizedStringFromTable(@"No More", @"DemoLocalizable", @"No More"),];
    self.loadMoreView.delegate = self;
}

- (void)setTableHeaderView:(UIView *)tableHeaderView {
    [super setTableHeaderView:tableHeaderView];
    
    if (self.emptyView == nil) {
        return;
    }
    
    if  (self.tableHeaderView != nil) {
        self.emptyView.frame = CGRectMake(0, self.tableHeaderView.bounds.size.height, self.bounds.size.width, self.bounds.size.height-self.tableHeaderView.bounds.size.height);
    } else {
        self.emptyView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    }
}

//MARK: Private
- (void)emptyViewHidden:(BOOL)hidden {
    if (self.emptyView != nil) {
        if (hidden == YES) {
            self.backgroundView = nil;
            [self.emptyView removeFromSuperview];
        } else {
            self.backgroundView = self.emptyBackgroundView;
            if  (self.tableHeaderView != nil) {
                self.emptyView.frame = CGRectMake(0, self.tableHeaderView.bounds.size.height, self.bounds.size.width, self.bounds.size.height-self.tableHeaderView.bounds.size.height);
            } else {
                self.emptyView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
            }
            [self addSubview:self.emptyView];
        }
    }
}

- (void)endLoadDataWithStatus:(EGOTableViewStatus)status {
    self.isLoading = NO;
    [self.egoheaderView refreshLastUpdatedDate];
    [self.egoheaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
    
    if (self.showLoadMore == NO) {
        return;
    }
    
    if (status == Empty) {
        self.tableFooterView = nil;
        self.loadMoreView.status = FootViewStatusNoMore;
    } else if (status == CanLoadMore) {
        self.tableFooterView = self.loadMoreView;
        self.loadMoreView.status = FootViewStatusCanLoadMore;
    } else if (status == NoMore) {
        self.tableFooterView = self.loadMoreView;
        self.loadMoreView.status = FootViewStatusNoMore;
    }
}

#pragma mark - Public Api
- (void)loadData {
    if (self.egoheaderView.superview == nil) {
        self.page = 1;
        self.isLoading = YES;
        if (self.egoDelegate != nil && [self.egoDelegate respondsToSelector:@selector(tableViewDidTriggerRefresh:)]) {
            [self.egoDelegate tableViewDidTriggerRefresh:self];
        }
    } else {
        [self.egoheaderView refreshLastUpdatedDate];
        [self.egoheaderView autoRefresh:self];
    }
}

- (void)endLoadWithAllCount:(NSInteger)allCount lastPageCount:(NSInteger)pageCount {
    [self emptyViewHidden:YES];
    [self reloadData];
    if (allCount == 0) {
        //如果tableview里面没有数据
        [self endLoadDataWithStatus:Empty];
        [self emptyViewHidden:NO];
    } else if (allCount >= 20 && pageCount >= 20) {
        //如果tableview里有整数倍的页数
        [self endLoadDataWithStatus:CanLoadMore];
    } else {
        //tableview里的数据不是整数页的
        [self endLoadDataWithStatus:NoMore];
    }
}

#pragma mark - Override
- (void)setEgoDelegate:(id<EGOTableViewDelegate>)egoDelegate {
    _egoDelegate = egoDelegate;
    self.delegate = self.egoDelegate;
    self.dataSource = self.egoDelegate;
}

- (void)setShowRefresh:(BOOL)showRefresh {
    _showRefresh = showRefresh;
    if (self.showRefresh == NO && self.egoheaderView.superview != nil) {
        [self.egoheaderView removeFromSuperview];
    } else if (self.showRefresh == YES && self.egoheaderView.superview == nil) {
        [self addSubview:self.egoheaderView];
    }
}

- (void)setShowLoadMore:(BOOL)showLoadMore {
    _showLoadMore = showLoadMore;
    if (self.showLoadMore == NO && self.loadMoreView != nil) {
        [self removeObserver:self.loadMoreView forKeyPath:@"contentOffset"];
        self.loadMoreView = nil;
    }
}

#pragma mark - Delegate
- (void)didTouchedWithStatus:(EGOFootViewStatus)status {
    if (status == FootViewStatusCanLoadMore && self.isLoading == NO) {
        self.page += 1;
        self.isLoading = YES;
        if (self.egoDelegate != nil && [self.egoDelegate respondsToSelector:@selector(tableViewDidTriggerLoadMore:)]) {
            [self.egoDelegate tableViewDidTriggerLoadMore:self];
        }
    }
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view {
    return self.isLoading;
}

- (NSDate *)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView *)view {
    NSDate *date = [[NSUserDefaults standardUserDefaults] objectForKey:@"EGODate"];
    if (date == nil) {
        date = [NSDate date];
    }
    [[NSUserDefaults standardUserDefaults] setObject:date forKey:@"EGODate"];
    return date;
}

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view {
    self.page = 1;
    self.isLoading = YES;
    if (self.egoDelegate != nil && [self.egoDelegate respondsToSelector:@selector(tableViewDidTriggerRefresh:)]) {
        [self.egoDelegate tableViewDidTriggerRefresh:self];
    }
}

@end
