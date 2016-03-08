//
//  NSString.m
//  libTripstersSDK
//
//  Created by TimTiger on 16/2/19.
//  Copyright © 2016年 Tripsters. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

+ (BOOL)hasContent:(NSString *)str {
    
    if (str == nil) {
        return NO;
    }
    
    if ([str isKindOfClass:[NSString class]] == NO) {
        return NO;
    }
    
    if (str.length < 1) {
        return NO;
    }
    
    return YES;
}

-(NSString *)dateString {
    NSTimeInterval tcreated  = self.doubleValue;
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:tcreated];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd HH:mm";
    NSString *receiveTime = [format stringFromDate:date];
    return receiveTime;
}

@end
