//
//  LocationManager.h
//  TripstersSDKDemo
//
//  Created by TimTiger on 16/2/29.
//  Copyright © 2016年 Tripsters. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationManager : NSObject

+ (void)getLocationWithCompletionHandler:(void (^)(CLPlacemark *placeMark,NSError *error))handler;

@end
