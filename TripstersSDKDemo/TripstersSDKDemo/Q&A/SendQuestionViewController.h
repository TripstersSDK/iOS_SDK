//
//  SendQuestionViewController.h
//  TripstersSDKDemo
//
//  Created by TimTiger on 16/2/26.
//  Copyright © 2016年 Tripsters. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QPSCountry;

@interface SendQuestionViewController : UITableViewController

@property (nonatomic,strong) QPSCountry *country;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
- (IBAction)addImageAction:(id)sender;

@end
