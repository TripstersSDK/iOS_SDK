//
//  SendReAnswerViewController.h
//  TripstersSDKDemo
//
//  Created by TimTiger on 16/3/1.
//  Copyright © 2016年 Tripsters. All rights reserved.
//

#import "TripstersAutoTableViewController.h"

@class QPSAnswer;
@class QPSQuestion;

@interface SendReAnswerViewController : UITableViewController

@property (nonatomic,strong) QPSAnswer *answer;
@property (nonatomic,strong) QPSQuestion *question;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
- (IBAction)addImageAction:(id)sender;
@end
