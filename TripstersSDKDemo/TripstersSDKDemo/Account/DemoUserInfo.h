//
//  DemoUserInfo.h
//  TripstersSDKDemo
//
//  Created by TimTiger on 16/3/14.
//  Copyright © 2016年 Tripsters. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DemoUserInfo : NSObject

@property (nonatomic,copy) NSString *userID;
@property (nonatomic,copy) NSString *avatar;
@property (nonatomic,copy) NSString *nickname;
@property (nonatomic,copy) NSString *location;
@property (nonatomic,copy) NSString  *gender;
@property (nonatomic,copy) NSString  *identity;
@property (nonatomic,copy) NSString  *country;

- (NSString *)identityString;

+ (void)saveUserInfo:(DemoUserInfo *)userInfo;

+(instancetype)loadUserInfo;

@end
