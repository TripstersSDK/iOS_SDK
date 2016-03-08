//
//  CityListViewController.h
//  TripstersSDKDemo
//
//  Created by TimTiger on 16/2/29.
//  Copyright © 2016年 Tripsters. All rights reserved.
//

#import "TripstersAutoTableViewController.h"

@class QPSCountry;

@interface CityListViewController : TripstersAutoTableViewController

@property (nonatomic,strong) QPSCountry *country;

@end
