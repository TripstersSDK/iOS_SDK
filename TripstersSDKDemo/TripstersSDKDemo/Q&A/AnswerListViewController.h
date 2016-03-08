//
//  AnswerListViewController.h
//  TripstersSDKDemo
//
//  Created by TimTiger on 16/2/25.
//  Copyright © 2016年 Tripsters. All rights reserved.
//

#import "TripstersAutoTableViewController.h"

@class QPSQuestion;
@interface AnswerListViewController : TripstersAutoTableViewController

@property (nonatomic,strong) QPSQuestion *question;

@end
