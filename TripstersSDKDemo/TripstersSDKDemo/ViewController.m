//
//  ViewController.m
//  TripstersSDKDemo
//
//  Created by TimTiger on 16/2/19.
//  Copyright © 2016年 Tripsters. All rights reserved.
//

#import "ViewController.h"
#import "QuestionListViewController.h"
#import "QPSApi.h"
#import "AccountAnswersViewController.h"
#import "AccountQuestionsViewController.h"
#import "AccountReceivedViewController.h"

@interface ViewController ()
@property (nonatomic,strong) NSArray *dataSource;
@property (nonatomic,readwrite) NSInteger unread;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib
    self.title = @"趣皮士SDK Demo";
    
    NSString *isLogin = [[NSUserDefaults standardUserDefaults] objectForKey:@"login"];
    if (isLogin == nil) {
        self.dataSource = @[@"未登陆"];
    } else {
        self.dataSource = @[@"已登陆",@"问答",@"我的提问",@"我的回答",@"我收到的回复",@"退出登录"];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:NewAnswerRecivedNotification object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)handleNotification:(NSNotification *)notification {
    if (self.dataSource.count > 1) {
        self.dataSource = @[@"已登陆",@"问答",@"我的提问",@"我的回答", @"我收到的回复(有未读)",@"退出登录"];
        [self.tableView reloadData];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [self.dataSource objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        //获取提问授权
        QPSAuthReq *req = [QPSAuthReq new];
        req.openid = @"beichen10001";  //必填
        req.avatar = @"http://e.hiphotos.baidu.com/image/h%3D200/sign=a0901680a3c27d1eba263cc42bd4adaf/b21bb051f819861842d54ba04ded2e738bd4e600.jpg"; //必填
        req.nickname = @"iOS SDK User1"; //必填
        req.gender = QPSUserGenderMale; //必填
        req.location = @"中国 北京"; //可选
        
        [QPSApi loginWithReq:req success:^(QPSAuthReq *req) {
            [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"login"];
            [self showSuccessNotificationWithText:@"登陆成功"];
            self.dataSource = @[@"已登陆",@"问答",@"我的提问",@"我的回答",@"我收到的回复",@"退出登录"];
            [self.tableView reloadData];
        } failure:^(QPSAuthReq *req, NSError *error) {
            [self showNotificationWithText:error.localizedDescription];
        }];
    }
    else if (indexPath.row == 1) {
        QuestionListViewController *questionList = [[QuestionListViewController alloc] init];
        [self.navigationController pushViewController:questionList animated:YES];
    } else if (indexPath.row == 2) {
        AccountQuestionsViewController *questionList = [[AccountQuestionsViewController alloc] init];
        questionList.title = @"我的提问";
        [self.navigationController pushViewController:questionList animated:YES];
    } else if (indexPath.row == 3) {
        AccountAnswersViewController *answerList = [[AccountAnswersViewController alloc] init];
        answerList.title = @"我的回答";
        [self.navigationController pushViewController:answerList animated:YES];
    } else if (indexPath.row == 4) {
        self.dataSource = @[@"已登陆",@"问答",@"我的提问",@"我的回答",@"我收到的回复",@"退出登录"];
        [self.tableView reloadData];
        AccountReceivedViewController *receivedList = [[AccountReceivedViewController alloc] init];
        [self.navigationController pushViewController:receivedList animated:YES];
    } else if (indexPath.row == 5) {
        [QPSApi logoutWithSuccessHandler:^{
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"login"];
            [self showSuccessNotificationWithText:@"已退出登陆"];
            self.dataSource = @[@"未登陆"];
            [self.tableView reloadData];
        } failure:^(NSError *error) {
            [self showNotificationWithText:error.description];
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
