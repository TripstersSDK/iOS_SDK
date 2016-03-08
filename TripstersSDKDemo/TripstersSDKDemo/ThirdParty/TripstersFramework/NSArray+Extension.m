//
//  NSArray+NSArray_Extension.m
//  libTripstersSDK
//
//  Created by TimTiger on 16/2/19.
//  Copyright © 2016年 Tripsters. All rights reserved.
//

#import "NSArray+Extension.h"

@implementation NSArray (Extension)

+(BOOL)hasContent:(NSArray *)array {
    if (array == nil) {
        return NO;
    }
    
    if ([array isKindOfClass:[NSNull class]]) {
        return NO;
    }
    
    if (array.count < 1) {
        return NO;
    }
    
    return YES;
}

@end
