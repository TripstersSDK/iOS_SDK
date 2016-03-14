//
//  AccountOtherInfoViewController.m
//  TripstersSDKDemo
//
//  Created by TimTiger on 16/3/14.
//  Copyright © 2016年 Tripsters. All rights reserved.
//

#import "AccountOtherInfoViewController.h"
#import "UIImageView+WebCache.h"
#import "QPSApi.h"
#import "QPSApiObject+Extension.h"
#import "AccountQuestionsViewController.h"
#import "AccountAnswersViewController.h"

@implementation AccountOtherInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    [self setLeftItemWithTitle:@"返回"];
    
    [self.avatarView sd_setImageWithURL:[NSURL URLWithString:self.user.avatar]];
    self.nicknameLabel.text = self.user.nickname;
    self.identityLabel.text = self.user.identityString;
    
    NSLog(@"%d",self.user.isOwn);
}

- (void)onLeftItemAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    if (indexPath.section == 0 && indexPath.row == 0) {
        
    } else if (indexPath.section == 1 && indexPath.row == 0) {
        AccountQuestionsViewController *questionList = [[AccountQuestionsViewController alloc] init];
        questionList.title = @"ta的提问";
        [self.navigationController pushViewController:questionList animated:YES];
    } else if (indexPath.section == 1 && indexPath.row == 1) {
        AccountAnswersViewController *answerList = [[AccountAnswersViewController alloc] init];
        answerList.title = @"ta的回答";
        [self.navigationController pushViewController:answerList animated:YES];
    }
}

@end
