//
//  AnswerTableViewCell.h
//  TripstersSDKDemo
//
//  Created by TimTiger on 16/2/29.
//  Copyright © 2016年 Tripsters. All rights reserved.
//

#import <UIKit/UIKit.h>


@class QPSAnswer,UserInfoView;
@protocol AnswerTableViewCellDelegate;
@interface AnswerTableViewCell : UITableViewCell
@property (nonatomic,weak) id <AnswerTableViewCellDelegate> delegate;
@property (nonatomic,strong) UserInfoView *userInfoView;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UIImageView *pictureView;
@property (nonatomic,strong) UILabel *timeLabel;

+ (CGFloat)heightWithAnswer:(QPSAnswer *)answer cellWidth:(CGFloat)width;
- (void)setCellWithAnswer:(QPSAnswer *)answer;

@end

@protocol AnswerTableViewCellDelegate <NSObject>

-(void)cellUserInfoDidSelected:(AnswerTableViewCell *)cell;

@end
