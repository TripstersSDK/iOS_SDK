//
//  DemoViewCreater.m
//  TripstersSDKDemo
//
//  Created by TimTiger on 16/3/2.
//  Copyright © 2016年 Tripsters. All rights reserved.
//

#import "DemoViewCreater.h"

@implementation DemoViewCreater

+(UILabel *)textLabel {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14.0f];
    label.textColor = [UIColor darkTextColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.numberOfLines = 0;
    return label;
}

+(UILabel *)citysLabel {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:13.0f];
    label.textColor = [UIColor darkGrayColor];
    label.textAlignment = NSTextAlignmentRight;
    label.numberOfLines = 1;
    return label;
}

+(UILabel *)timeLabel {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:13.0f];
    label.textColor = [UIColor darkGrayColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.numberOfLines = 1;
    return label;
}

+ (UIButton *)locationButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom]; //lbs_show_location@2x
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [button setImage:[UIImage imageNamed:@"lbs_show_location.png"] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor clearColor];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    button.clipsToBounds = true;
    return button;
}

@end
