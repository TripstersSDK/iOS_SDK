//
//  NSString.h
//  libTripstersSDK
//
//  Created by TimTiger on 16/2/19.
//  Copyright © 2016年 Tripsters. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

+ (BOOL)hasContent:(NSString *)str;

-(NSString *)dateString;

@end
