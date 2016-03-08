//
//  QuestionTableViewCell.h
//  TripstersSDKDemo
//
//  Created by TimTiger on 16/3/2.
//  Copyright © 2016年 Tripsters. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QPSQuestion,UserInfoView;
@protocol QuestionTableViewCellDelegate;
@interface QuestionTableViewCell : UITableViewCell

@property (nonatomic,weak) id <QuestionTableViewCellDelegate> delegate;
@property (nonatomic,strong) UserInfoView *userInfoView;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UIImageView *pictureView;
@property (nonatomic,strong) UILabel *cityLabel;
@property (nonatomic,strong) UIButton *locationButton;
@property (nonatomic,strong) UILabel *timeLabel;

+ (CGFloat)heightWithQuestion:(QPSQuestion *)question cellWidth:(CGFloat)width;
- (void)setCellWithQuestion:(QPSQuestion *)question;

@end

@protocol QuestionTableViewCellDelegate <NSObject>

-(void)cellUserInfoDidSelected:(QuestionTableViewCell *)cell;

@end