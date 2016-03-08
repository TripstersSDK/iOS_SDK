//
//  QuestionTableViewCell.m
//  TripstersSDKDemo
//
//  Created by TimTiger on 16/3/2.
//  Copyright © 2016年 Tripsters. All rights reserved.
//

#import "QuestionTableViewCell.h"
#import "QPSApi.h"
#import "UIImageView+WebCache.h"
#import "NSString+Extension.h"
#import "UserInfoView.h"
#import "DemoViewCreater.h"
#import "QPSApiObject+Extension.h"

@interface QuestionTableViewCell () <UserInfoViewDelegate>

@end

@implementation QuestionTableViewCell

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
    self.cityLabel = [DemoViewCreater citysLabel];
    [self addSubview:self.cityLabel];
    self.locationButton = [DemoViewCreater locationButton];
    [self addSubview:self.locationButton];
    self.timeLabel = [DemoViewCreater timeLabel];
    [self addSubview:self.timeLabel];
}

+ (CGFloat)heightWithQuestion:(QPSQuestion *)question cellWidth:(CGFloat)width {
    CGFloat totalHeight = 15+30+15;
    CGSize textSize = [question.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(width-30, 10000)];
    totalHeight += textSize.height;
    if ([NSString hasContent:question.picInfo.picUrlString]) {
        totalHeight += 100;
    }
    if ([NSString hasContent:question.address]) {
        totalHeight += 25;
    }
    totalHeight += 25;
    totalHeight += 15;
    return totalHeight;
}

- (void)setCellWithQuestion:(QPSQuestion *)question {
    
    if ([NSString hasContent:question.picInfo.picUrlString]) {
        [self.pictureView sd_setImageWithURL:[NSURL URLWithString:question.picInfo.picUrlString] placeholderImage:nil];
    }
    [self.userInfoView setViewWithUser:question.asker];
    self.contentLabel.text = question.text;
    CGSize textSize = [question.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(self.bounds.size.width-30, 10000)];
    self.contentLabel.frame = CGRectMake(15, CGRectGetMaxY(self.userInfoView.frame), textSize.width, textSize.height);
    if ([NSString hasContent:question.picInfo.picUrlString]) {
        [self.pictureView sd_setImageWithURL:[NSURL URLWithString:question.picInfo.picUrlString] placeholderImage:nil];
        self.pictureView.frame = CGRectMake(15, CGRectGetMaxY(self.contentLabel.frame)+10,90, 90);
    } else {
        self.pictureView.image = nil;
        self.pictureView.frame = CGRectMake(15, CGRectGetMaxY(self.contentLabel.frame), 90, 0);
    }
    if ([NSString hasContent:question.address]) {
        [self.locationButton setTitle:question.address forState:UIControlStateNormal];
        self.locationButton.frame = CGRectMake(15, CGRectGetMaxY(self.pictureView.frame)+10, self.bounds.size.width-30, 15);
    } else {
        [self.locationButton setTitle:@"" forState:UIControlStateNormal];
        self.locationButton.frame = CGRectMake(15, CGRectGetMaxY(self.pictureView.frame), self.bounds.size.width-30, 0);
    }
    self.cityLabel.frame = CGRectMake(135, CGRectGetMaxY(self.locationButton.frame)+10, self.bounds.size.width-150, 15);
    self.cityLabel.text = question.citysString;
    self.timeLabel.frame = CGRectMake(15, CGRectGetMaxY(self.locationButton.frame)+10, 120, 15);
    self.timeLabel.text = [question.created dateString];
}

- (void)infoView:(UserInfoView *)infoView avatarSelected:(UIImageView *)sender {
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(cellUserInfoDidSelected:)]) {
        [self.delegate cellUserInfoDidSelected:self];
    }
}

@end
