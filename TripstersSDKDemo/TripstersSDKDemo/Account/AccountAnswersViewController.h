//
//  AccountAnswersViewController.h
//  TripstersSDKDemo
//
//  Created by TimTiger on 16/3/1.
//  Copyright © 2016年 Tripsters. All rights reserved.
//

#import "TripstersAutoTableViewController.h"

@class QPSUser;

@interface AccountAnswersViewController : TripstersAutoTableViewController
@property (nonatomic,strong) QPSUser *user;
@end
