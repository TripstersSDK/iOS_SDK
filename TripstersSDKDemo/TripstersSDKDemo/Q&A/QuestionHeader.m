//
//  QuestionHeader.m
//  TripstersSDKDemo
//
//  Created by TimTiger on 16/2/29.
//  Copyright © 2016年 Tripsters. All rights reserved.
//

#import "QuestionHeader.h"
#import "QPSApi.h"
#import "UIImageView+WebCache.h"
#import "NSString+Extension.h"
#import "UserInfoView.h"
#import "DemoViewCreater.h"
#import "QPSApiObject+Extension.h"

@implementation QuestionHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    self.userInfoView = [[UserInfoView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 60)];
    [self addSubview:self.userInfoView];
    self.textLabel = [DemoViewCreater textLabel];
    [self addSubview:self.textLabel];
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.imageView.clipsToBounds = YES;
    [self addSubview:self.imageView];
    self.cityLabel = [DemoViewCreater citysLabel];
    [self addSubview:self.cityLabel];
    self.locationButton = [DemoViewCreater locationButton];
    [self addSubview:self.locationButton];
    self.timeLabel = [DemoViewCreater timeLabel];
    [self addSubview:self.timeLabel];
}

- (CGFloat)heightWithQuestion:(QPSQuestion *)question {
    CGFloat totalHeight = 15+30+15;
    CGSize textSize = [self.textLabel sizeThatFits:CGSizeMake(self.bounds.size.width-30, 10000)];
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

- (void)setHeaderWithQuestion:(QPSQuestion *)question {
    [self.userInfoView setViewWithUser:question.asker];
    self.textLabel.text = question.text;
    CGSize textSize = [self.textLabel sizeThatFits:CGSizeMake(self.bounds.size.width-30, 10000)];
    self.textLabel.frame = CGRectMake(15, CGRectGetMaxY(self.userInfoView.frame), textSize.width, textSize.height);
    if ([NSString hasContent:question.picInfo.picUrlString]) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:question.picInfo.picUrlString] placeholderImage:nil];
        self.imageView.frame = CGRectMake(15, CGRectGetMaxY(self.textLabel.frame)+10,90, 90);
    } else {
        self.imageView.image = nil;
        self.imageView.frame = CGRectMake(15, CGRectGetMaxY(self.textLabel.frame), 90, 0);
    }

    if ([NSString hasContent:question.address]) {
        [self.locationButton setTitle:question.address forState:UIControlStateNormal];
        self.locationButton.frame = CGRectMake(15, CGRectGetMaxY(self.imageView.frame)+10, self.bounds.size.width-30, 15);
    } else {
        [self.locationButton setTitle:@"" forState:UIControlStateNormal];
        self.locationButton.frame = CGRectMake(15, CGRectGetMaxY(self.imageView.frame), self.bounds.size.width-30, 0);
    }
    self.cityLabel.frame = CGRectMake(135, CGRectGetMaxY(self.locationButton.frame)+10, self.bounds.size.width-150, 15);
    self.cityLabel.text = question.citysString;
    self.timeLabel.frame = CGRectMake(15, CGRectGetMaxY(self.locationButton.frame)+10, 120, 15);
    self.timeLabel.text = [question.created dateString];
}

@end
