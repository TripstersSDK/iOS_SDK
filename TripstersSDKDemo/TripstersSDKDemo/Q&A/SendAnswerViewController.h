//
//  SendAnswerViewController.h
//  TripstersSDKDemo
//
//  Created by TimTiger on 16/2/29.
//  Copyright © 2016年 Tripsters. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QPSQuestion;
@interface SendAnswerViewController : UITableViewController

@property (nonatomic,strong) QPSQuestion *question;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
- (IBAction)addImageAction:(id)sender;
@end
