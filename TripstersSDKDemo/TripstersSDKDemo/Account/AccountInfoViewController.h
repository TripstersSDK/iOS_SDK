//
//  AccountInfoViewController.h
//  TripstersSDKDemo
//
//  Created by TimTiger on 16/3/2.
//  Copyright © 2016年 Tripsters. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QPSUser;

@interface AccountInfoViewController : UITableViewController

@property (nonatomic,strong) QPSUser *user;

@property (weak, nonatomic) IBOutlet UIImageView *avatarView;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *identityLabel;

@end
