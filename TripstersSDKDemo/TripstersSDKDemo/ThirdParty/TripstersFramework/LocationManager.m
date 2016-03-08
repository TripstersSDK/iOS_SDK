//
//  LocationManager.m
//  TripstersSDKDemo
//
//  Created by TimTiger on 16/2/29.
//  Copyright © 2016年 Tripsters. All rights reserved.
//

#import "LocationManager.h"
#import "Macro.h"
#import "NSError+Extension.h"

@interface LocationManager () <CLLocationManagerDelegate>
Declare_ShareInstance(LocationManager);

@property (nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic,strong) CLGeocoder *geocoder;
@property (nonatomic,copy) void(^locationHandler)(CLPlacemark *placeMark,NSError *error);

@end

@implementation LocationManager
Realize_ShareInstance(LocationManager);

- (instancetype)init {
    self = [super init];
    if (self) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.activityType = CLActivityTypeFitness;
        if (AVAILABLE_IOS8) {
            [self.locationManager requestWhenInUseAuthorization];
        } else {    
        }
        self.geocoder = [[CLGeocoder alloc] init];
    }
    return self;
}

+ (void)getLocationWithCompletionHandler:(void (^)(CLPlacemark *placeMark,NSError *error))handler {
    [LocationManager shareInstance].locationHandler = handler;
    [[LocationManager shareInstance] startUpdatingLocation];
}

- (void)startUpdatingLocation {
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        self.locationHandler(nil,[NSError errorWithlocalizedDescription:@"Location authorization status is denied" errorCode:-100]);
        return;
    }
    
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager.delegate = self;
        [self.locationManager startUpdatingLocation];
    } else {
        self.locationHandler(nil,[NSError errorWithlocalizedDescription:@"Device no location server" errorCode:-100]);
    }
}

- (void)stopUpdatingLocation {
    [self.locationManager stopUpdatingLocation];
}

#pragma mark - Delegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations {
    
    if (locations.count < 1) {
        self.locationHandler(nil,[NSError errorWithlocalizedDescription:@"update location failed" errorCode:-100]);
    }
    
    [self.geocoder reverseGeocodeLocation:locations.lastObject
                        completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks != nil && placemarks.count > 0) {
            CLPlacemark *mark = placemarks.firstObject;
            self.locationHandler(mark,nil);
        } else {
            self.locationHandler(nil,[NSError errorWithlocalizedDescription:@"reverse geocode location failed" errorCode:-100]);
        }
    }];
    
    self.locationManager.delegate = nil;
    [self stopUpdatingLocation];
}



@end
