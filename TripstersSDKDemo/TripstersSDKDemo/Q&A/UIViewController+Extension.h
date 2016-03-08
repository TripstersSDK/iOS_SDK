//
//  UIViewController+Extension.h
//  TripstersSDKDemo
//
//  Created by TimTiger on 16/2/20.
//  Copyright © 2016年 Tripsters. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Extension)

- (void)setLeftItemWithTitle:(NSString *)title;
- (void)setRightItemWithTitle:(NSString *)title;
- (void)onLeftItemAction:(UIButton *)sender;
- (void)onRightItemAction:(UIButton *)sender;

- (void)pushViewController:(UIViewController *)controller;

- (void)showNotificationWithText:(NSString *)text;

- (void)showSuccessNotificationWithText:(NSString *)text;

@end
