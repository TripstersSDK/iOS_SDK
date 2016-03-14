//
//  DemoAccountManager.h
//  TripstersSDKDemo
//
//  Created by TimTiger on 16/3/14.
//  Copyright © 2016年 Tripsters. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Macro.h"
#import "DemoUserInfo.h"

@interface DemoAccountManager : NSObject
Declare_ShareInstance(DemoAccountManager);

@property (nonatomic,strong) DemoUserInfo *currentUser;

+(BOOL)isLogin;

+(DemoUserInfo *)loginFunc;

+(BOOL)logoutFunc;

@end
