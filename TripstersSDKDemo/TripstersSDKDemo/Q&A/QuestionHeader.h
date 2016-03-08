//
//  QuestionHeader.h
//  TripstersSDKDemo
//
//  Created by TimTiger on 16/2/29.
//  Copyright © 2016年 Tripsters. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QPSQuestion;
@class UserInfoView;

@interface QuestionHeader : UIView

@property (nonatomic,strong) UserInfoView *userInfoView;
@property (nonatomic,strong) UILabel *textLabel;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel *cityLabel;
@property (nonatomic,strong) UIButton *locationButton;
@property (nonatomic,strong) UILabel *timeLabel;

- (void)setHeaderWithQuestion:(QPSQuestion *)question;
- (CGFloat)heightWithQuestion:(QPSQuestion *)question;

@end
