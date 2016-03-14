//
//  DemoAccountManager.m
//  TripstersSDKDemo
//
//  Created by TimTiger on 16/3/14.
//  Copyright © 2016年 Tripsters. All rights reserved.
//

#import "DemoAccountManager.h"

@implementation DemoAccountManager
Realize_ShareInstance(DemoAccountManager);

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.currentUser = [DemoUserInfo loadUserInfo];
    }
    return self;
}

+(BOOL)isLogin {
    NSString *isLogin = [[NSUserDefaults standardUserDefaults] objectForKey:@"login"];
    if (isLogin == nil) {
        return NO;
    }
    return YES;
}

+(DemoUserInfo *)loginFunc {
    DemoUserInfo *userInfo = [[DemoUserInfo alloc] init];
    userInfo.nickname = @"山东旅行家";
    userInfo.avatar     = @"http://hiphotos.baidu.com/baidu/pic/item/83025aafa40f4bfb2611a50d044f78f0f63618a1.jpg";
    userInfo.userID = @"'9729547933";
    userInfo.gender = @"m";
    userInfo.location = @"中国 山东"; //可选
    return userInfo;
}

+(BOOL)logoutFunc {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"login"];
    return YES;
}

@end
