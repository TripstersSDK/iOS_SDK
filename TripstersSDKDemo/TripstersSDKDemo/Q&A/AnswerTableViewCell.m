//
//  AnswerTableViewCell.m
//  TripstersSDKDemo
//
//  Created by TimTiger on 16/2/29.
//  Copyright © 2016年 Tripsters. All rights reserved.
//

#import "AnswerTableViewCell.h"
#import "QPSApi.h"
#import "UIImageView+WebCache.h"
#import "NSString+Extension.h"
#import "UserInfoView.h"
#import "DemoViewCreater.h"
#import "QPSApiObject+Extension.h"

@interface AnswerTableViewCell () <UserInfoViewDelegate>

@end

@implementation AnswerTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    self.userInfoView = [[UserInfoView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 60)];
    self.userInfoView.delegate = self;
    [self addSubview:self.userInfoView];
    self.contentLabel = [DemoViewCreater textLabel];
    [self addSubview:self.contentLabel];
    self.pictureView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.pictureView.clipsToBounds = YES;
    [self addSubview:self.pictureView];
    self.timeLabel = [DemoViewCreater timeLabel];
    [self addSubview:self.timeLabel];
}

+ (CGFloat)heightWithAnswer:(QPSAnswer *)answer cellWidth:(CGFloat)width {
    CGFloat totalHeight = 15+30+15;
    CGSize textSize = [answer.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(width-30, 10000)];
    totalHeight += textSize.height;
    if ([NSString hasContent:answer.picInfo.picUrlString]) {
        totalHeight += 100;
    }
    totalHeight += 25;
    totalHeight += 15;
    return totalHeight;
}

- (void)setCellWithAnswer:(QPSAnswer *)answer {

    if ([NSString hasContent:answer.picInfo.picUrlString]) {
        [self.pictureView sd_setImageWithURL:[NSURL URLWithString:answer.picInfo.picUrlString] placeholderImage:nil];
    }
    self.timeLabel.text = [answer.created dateString];
    [self.userInfoView setViewWithUser:answer.answerer];
    self.contentLabel.text = answer.text;
    CGSize textSize = [answer.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(self.bounds.size.width-30, 10000)];
    self.contentLabel.frame = CGRectMake(15, CGRectGetMaxY(self.userInfoView.frame), textSize.width, textSize.height);
    if ([NSString hasContent:answer.picInfo.picUrlString]) {
        [self.pictureView sd_setImageWithURL:[NSURL URLWithString:answer.picInfo.picUrlString] placeholderImage:nil];
        self.pictureView.frame = CGRectMake(15, CGRectGetMaxY(self.contentLabel.frame)+10,90, 90);
    } else {
        self.pictureView.image = nil;
        self.pictureView.frame = CGRectMake(15, CGRectGetMaxY(self.contentLabel.frame), 90, 0);
    }
    self.timeLabel.frame = CGRectMake(15, CGRectGetMaxY(self.pictureView.frame)+10, 120, 15);
    self.timeLabel.text = [answer.created dateString];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)infoView:(UserInfoView *)infoView avatarSelected:(UIImageView *)sender {
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(cellUserInfoDidSelected:)]) {
        [self.delegate cellUserInfoDidSelected:self];
    }
}

@end
