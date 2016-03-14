//
//  DemoUserInfo.m
//  TripstersSDKDemo
//
//  Created by TimTiger on 16/3/14.
//  Copyright © 2016年 Tripsters. All rights reserved.
//

#import "DemoUserInfo.h"
#import "QPSApi.h"

@implementation DemoUserInfo

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.avatar = [coder decodeObjectForKey:@"avatar"];
        self.nickname = [coder decodeObjectForKey:@"nickname"];
        self.location = [coder decodeObjectForKey:@"location"];
        self.gender = [coder decodeObjectForKey:@"gender"];
        self.userID = [coder decodeObjectForKey:@"userid"];
        self.identity = [coder decodeObjectForKey:@"identity"];
        self.country = [coder decodeObjectForKey:@"country"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.avatar forKey:@"avatar"];
    [coder encodeObject:self.nickname forKey:@"nickname"];
    [coder encodeObject:self.location forKey:@"location"];
    [coder encodeObject:self.gender forKey:@"gender"];
    [coder encodeObject:self.userID forKey:@"userid"];
    [coder encodeObject:self.identity forKey:@"identity"];
    [coder encodeObject:self.country forKey:@"country"];
}

+ (void)saveUserInfo:(DemoUserInfo *)userInfo {
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Library/User_Cache"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path] == NO) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    path = [path stringByAppendingPathComponent:@"demouser.dat"];
    [NSKeyedArchiver archiveRootObject:userInfo toFile:path];
}

+(instancetype)loadUserInfo {
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Library/User_Cache"];
    path = [path stringByAppendingPathComponent:@"demouser.dat"];
    DemoUserInfo *userinfo = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    return userinfo;
}

-(NSString *)identityString {
    if (self.identity == QPSUserIdentityMaster || self.identity == QPSUserIdentityService) {
        return [NSString stringWithFormat:@"%@达人",self.country];
    } else if (self.identity == QPSUserIdentityStar) {
        return @"旅行达人";
    } else {
        return @"旅行者";
    }
}

@end
