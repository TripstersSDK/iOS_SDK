//
//  EGOLoadMoreFootView.h
//  TripstersSDKDemo
//
//  Created by TimTiger on 16/2/20.
//  Copyright © 2016年 Tripsters. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * FootView 状态
 */
typedef NS_ENUM(NSInteger,EGOFootViewStatus) {
    FootViewStatusCanLoadMore = 0,  //能加载更多
    FootViewStatusLoadingMore = 1,    //正在加载
    FootViewStatusNoMore = 2,          //没有更多了
};

@protocol EGOLoadMoreFootViewDelegate;
@interface EGOLoadMoreFootView : UIButton

@property (nonatomic,weak) id <EGOLoadMoreFootViewDelegate> delegate;
@property (nonatomic,readonly) UIActivityIndicatorView *activityView;

@property (nonatomic,readwrite) EGOFootViewStatus status;
/** 默认 [@"加载更多",@"加载中...",@"没有更多了"] */
@property (nonatomic,strong) NSArray *remindStrArray;

@end

@protocol EGOLoadMoreFootViewDelegate <NSObject>
/**
 *  拖动或者点按加载按钮的回调
 *
 *  @param status 按下时视图所处的状态
 */
- (void)didTouchedWithStatus:(EGOFootViewStatus)status;
@end
