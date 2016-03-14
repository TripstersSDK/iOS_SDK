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
#import "AccountReceivedViewController.h"
#import "DemoUserInfo.h"
#import "DemoAccountManager.h"

@implementation AccountInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"我的";
    [self setLeftItemWithTitle:@"返回"];
    [self updateView:[DemoAccountManager shareInstance].currentUser];
}

- (void)updateView:(DemoUserInfo *)userInfo {
    if ([DemoAccountManager isLogin]) {
        [self.avatarView sd_setImageWithURL:[NSURL URLWithString:userInfo.avatar]];
        self.nicknameLabel.text = userInfo.nickname;
        self.identityLabel.text = userInfo.identityString;
    } else {
        self.avatarView.image = nil;
        self.nicknameLabel.text = @"--";
        self.identityLabel.text = @"未登录";
    }
}

- (void)onLeftItemAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    if (indexPath.section == 0 && indexPath.row == 0) {
        NSString *isLogin = [[NSUserDefaults standardUserDefaults] objectForKey:@"login"];
        if (isLogin == nil) {  //未登录，去登录
            
            //1.调用登陆接口获得了用户信息
            DemoUserInfo *userInfo = [DemoAccountManager loginFunc];
            
            //2.用用户信息调趣皮士接口，获取问答接口的授权
            QPSAuthReq *req = [QPSAuthReq new];
            req.openid = userInfo.userID; //必填  /** 接入平台自身用户的唯一ID  */
            req.avatar = userInfo.avatar; //必填
            req.nickname = userInfo.nickname; //必填
            if ([userInfo.gender isEqualToString:@"m"]) {
                req.gender = QPSUserGenderMale; //必填
            } else {
                req.gender = QPSUserGenderFemale; //必填
            }
            req.location = userInfo.location; //可选
            
            [QPSApi loginWithReq:req success:^(QPSAuthReq *req,QPSUser *user) {
                [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"login"];
                userInfo.country = user.country;
                userInfo.identity = user.identity;
                [DemoUserInfo saveUserInfo:userInfo];
                [DemoAccountManager shareInstance].currentUser = userInfo;
                [self showSuccessNotificationWithText:@"登录成功"];
                [self updateView:userInfo];
            } failure:^(QPSAuthReq *req, NSError *error) {
                [self showNotificationWithText:error.localizedDescription];
            }];
        } else {  //退出登录
            [QPSApi logoutWithSuccessHandler:^{
                [DemoAccountManager logoutFunc];
                [self showSuccessNotificationWithText:@"已退出登录"];
                [self updateView:nil];
            } failure:^(NSError *error) {
                [self showNotificationWithText:error.description];
            }];
        }
    } else if (indexPath.section == 1 && indexPath.row == 0) {
        AccountQuestionsViewController *questionList = [[AccountQuestionsViewController alloc] init];
        questionList.title = @"我的提问";
        [self.navigationController pushViewController:questionList animated:YES];
    } else if (indexPath.section == 1 && indexPath.row == 1) {
        AccountAnswersViewController *answerList = [[AccountAnswersViewController alloc] init];
        answerList.title = @"我的回答";
        [self.navigationController pushViewController:answerList animated:YES];
    }  else if (indexPath.section == 1 && indexPath.row == 2) {
        AccountReceivedViewController *receivedList = [[AccountReceivedViewController alloc] init];
        receivedList.title = @"我收到的回答";
        [self.navigationController pushViewController:receivedList animated:YES];
    }
}

@end
