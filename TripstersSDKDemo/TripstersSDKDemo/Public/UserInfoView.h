//
//  UserInfoView.h
//  TripstersSDKDemo
//
//  Created by TimTiger on 16/3/2.
//  Copyright © 2016年 Tripsters. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QPSUser;
@protocol UserInfoViewDelegate;

@interface UserInfoView : UIView

@property (nonatomic,weak) id <UserInfoViewDelegate> delegate;
// 头像
@property (nonatomic,strong) UIImageView *avatarView;
//昵称
@property (nonatomic,strong) UILabel *nicknameLabel;
//身份 和 常住地
@property (nonatomic,strong) UILabel *identityLabel;

- (void)setViewWithUser:(QPSUser *)user;

@end

@protocol UserInfoViewDelegate <NSObject>
@required
- (void)infoView:(UserInfoView *)infoView avatarSelected:(UIImageView *)sender;

@end
