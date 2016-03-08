//
//  UserInfoView.m
//  TripstersSDKDemo
//
//  Created by TimTiger on 16/3/2.
//  Copyright © 2016年 Tripsters. All rights reserved.
//

#import "UserInfoView.h"
#import "QPSApiObject+Extension.h"
#import "UIImageView+WebCache.h"

@implementation UserInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    self.avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(15,15, 30, 30)];
    self.avatarView.clipsToBounds = true;
    self.avatarView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.avatarView.userInteractionEnabled = true;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] init];
    [gesture addTarget:self action:@selector(avatarAction:)];
    [self.avatarView addGestureRecognizer:gesture];
    [self addSubview:self.avatarView];
    
    self.nicknameLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 15, self.bounds.size.width-55-15, 15)];
    self.nicknameLabel.textColor = [UIColor colorWithRed:46/255.0 green:167/255.0 blue:224/255.0 alpha:1];
    self.nicknameLabel.font = [UIFont systemFontOfSize:14];
    self.nicknameLabel.numberOfLines = 1;
    self.nicknameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self addSubview:self.nicknameLabel];
    
    self.identityLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 30, self.bounds.size.width-55-15, 15)];
    self.identityLabel.textColor = [UIColor darkGrayColor];
    self.identityLabel.font = [UIFont systemFontOfSize:13];
    self.identityLabel.numberOfLines = 1;
    self.identityLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self addSubview:self.identityLabel];
}

- (void)setViewWithUser:(QPSUser *)user {
    [self.avatarView sd_setImageWithURL:[NSURL URLWithString:user.avatar] placeholderImage:nil];
    self.nicknameLabel.text = user.nickname;
    self.identityLabel.text = [NSString stringWithFormat:@"%@ · %@",user.identityString,user.location];
}

- (void)avatarAction:(UITapGestureRecognizer *)sender {
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(infoView:avatarSelected:)]) {
        [self.delegate infoView:self avatarSelected:self.avatarView];
    }
}

@end
