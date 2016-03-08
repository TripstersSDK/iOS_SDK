//
//  EGOLoadMoreFootView.m
//  TripstersSDKDemo
//
//  Created by TimTiger on 16/2/20.
//  Copyright © 2016年 Tripsters. All rights reserved.
//

#import "EGOLoadMoreFootView.h"

@interface EGOLoadMoreFootView ()
@end

@implementation EGOLoadMoreFootView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.remindStrArray = @[@"加载更多",@"加载中...",@"没有更多了"];
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:self.activityView];
        if ([self allTargets].count == 0) {
            [self addTarget:self action:@selector(onButtonAction:)  forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return self;
}

#pragma mark - Private Api
//MARK: - Private API
- (void)loadMore {
    if (self.status == FootViewStatusCanLoadMore) {
        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didTouchedWithStatus:)]) {
            [self.delegate didTouchedWithStatus:self.status];
        }
        self.status = FootViewStatusLoadingMore;
    }
}

#pragma mark - Override
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    UITableView *t_tableView = (UITableView *)object;
    if ((t_tableView.contentOffset.y > t_tableView.contentSize.height-t_tableView.bounds.size.height+40) && (t_tableView.dragging == YES)) {
        [self loadMore];
    }
}

- (void)setStatus:(EGOFootViewStatus)status {
    _status = status;
    [self setTitle:self.remindStrArray[status] forState:UIControlStateNormal];
    [self.titleLabel sizeToFit];
    self.titleLabel.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    if (self.status == FootViewStatusLoadingMore) {
        self.activityView.center = CGPointMake(self.titleLabel.frame.origin.x-20, self.bounds.size.height/2);
        [self.activityView startAnimating];
        self.activityView.hidden = false;
    } else {
        self.activityView.hidden = true;
        [self.activityView stopAnimating];
    }
}

#pragma mark - Actions
- (void)onButtonAction:(UIButton *)sender {
    [self loadMore];
}

@end
