//
//  AccountInfoViewController.m
//  TripstersSDKDemo
//
//  Created by TimTiger on 16/3/2.
//  Copyright © 2016年 Tripsters. All rights reserved.
//

#import "AccountInfoViewController.h"
#import "UIImageView+WebCache.h"
#import "QPSApi.h"
#import "QPSApiObject+Extension.h"
#import "AccountQuestionsViewController.h"
#import "AccountAnswersViewController.h"

@implementation AccountInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.user == nil) {
        self.user = [QPSApi getUserInfo];
    }

    self.title = self.user.nickname;
    [self.avatarView sd_setImageWithURL:[NSURL URLWithString:self.user.avatar]];
    self.nicknameLabel.text = self.user.nickname;
    self.identityLabel.text = [self.user identityString];
    
    [self setLeftItemWithTitle:@"返回"];
}

- (void)onLeftItemAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row == 0) {
        AccountQuestionsViewController *questionList = [[AccountQuestionsViewController alloc] init];
        questionList.title = @"ta的提问";
        questionList.user = self.user;
        [self.navigationController pushViewController:questionList animated:YES];
    } else if (indexPath.section == 1 && indexPath.row == 1) {
        AccountAnswersViewController *answerList = [[AccountAnswersViewController alloc] init];
        answerList.title = @"ta的回答";
        answerList.user = self.user;
        [self.navigationController pushViewController:answerList animated:YES];
    }
}

@end
