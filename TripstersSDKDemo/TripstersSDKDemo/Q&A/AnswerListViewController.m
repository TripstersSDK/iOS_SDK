//
//  AnswerListViewController.m
//  TripstersSDKDemo
//
//  Created by TimTiger on 16/2/25.
//  Copyright © 2016年 Tripsters. All rights reserved.
//

#import "AnswerListViewController.h"
#import "QPSApi.h"
#import "QuestionHeader.h"
#import "AnswerTableViewCell.h"
#import <Foundation/Foundation.h>
#import "SendAnswerViewController.h"
#import "Macro.h"
#import "SendReAnswerViewController.h"
#import "AccountInfoViewController.h"

@interface AnswerListViewController () <AnswerTableViewCellDelegate>

@property (nonatomic,strong) QPSAnswerListReq *request;

@end

@implementation AnswerListViewController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)initData {
    [super initData];
    self.request = [[QPSAnswerListReq alloc] init];
    self.request.question = self.question;
    [self addNotificationObserver];
}

- (void)initView {
    [super initView];
    self.title = @"问题详情";
    [self setLeftItemWithTitle:@"返回"];
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
    
    UIButton *sendAnswerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-44, self.view.bounds.size.width, 44)];
    [sendAnswerButton setTitle:@"回答" forState:UIControlStateNormal];
    [sendAnswerButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    sendAnswerButton.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [sendAnswerButton addTarget:self action:@selector(sendAnswer) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendAnswerButton];
    
    QPSQuestionDetailReq *req = [[QPSQuestionDetailReq alloc] init];
    req.question = self.question;
    [QPSApi getQuestionDetailWithReq:req success:^(QPSQuestionDetailReq *req, QPSQuestion *question) {
        self.question = question;
        QuestionHeader *headerView = [[QuestionHeader alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 20)];
        [headerView setHeaderWithQuestion:self.question];
        CGFloat height = [headerView heightWithQuestion:question];
        headerView.frame = CGRectMake(0, 0, self.view.bounds.size.width, height);
        self.tableView.tableHeaderView = headerView;
        [self.tableView reloadData];
    } failure:^(QPSQuestionDetailReq *req, NSError *error) {
        [self showNotificationWithText:error.localizedDescription];
    }];
}

- (void)requestData {
    self.request.page = self.tableView.page;
    [QPSApi getAnswerListWithReq:self.request success:^(QPSAnswerListReq *req, NSArray *responseObject) {
        [self refreshDataWithArray:responseObject];
    } failure:^(QPSAnswerListReq *req, NSError *error) {
        [self refreshDataWithArray:[NSArray new]];
    }];
}

- (void)dealloc
{
    [self removeNotificationObserver];
}

#pragma mark - Notification
- (void)addNotificationObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:ANSWERSENDSUCCESS object:nil];
}

- (void)removeNotificationObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)handleNotification:(NSNotification *)notification {
   if ([notification.name isEqualToString:ANSWERSENDSUCCESS]) {
        [self reloadData];
    }
}

#pragma mark - Actions
- (void)onLeftItemAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)sendAnswer {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SendAnswerViewController *sendAnswerVC = [story instantiateViewControllerWithIdentifier:@"SendAnswerViewController"];
    sendAnswerVC.question = self.request.question;
    [self pushViewController:sendAnswerVC];
}

#pragma mark - Delegate MARK: - DataSource and Delgate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
    label.backgroundColor = [UIColor lightGrayColor];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    label.text = [NSString stringWithFormat:@"%@个回答",self.question.answer_num];
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    QPSAnswer *answer = [self.dataArray objectAtIndex:indexPath.row];
    return [AnswerTableViewCell heightWithAnswer:answer cellWidth:self.view.bounds.size.width];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CountryCellIdentifier";
    AnswerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[AnswerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CountryCellIdentifier"];
    }
    cell.delegate = self;
    QPSAnswer *answer = [self.dataArray objectAtIndex:indexPath.row];
    [cell setCellWithAnswer:answer];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    QPSAnswer *answer = [self.dataArray objectAtIndex:indexPath.row];
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SendReAnswerViewController *sendReAnswerVC = [story instantiateViewControllerWithIdentifier:@"SendReAnswerViewController"];
    sendReAnswerVC.question = self.question;
    sendReAnswerVC.answer = answer;
    [self pushViewController:sendReAnswerVC];
}

- (void)cellUserInfoDidSelected:(AnswerTableViewCell *)cell {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    QPSAnswer *answer = [self.dataArray objectAtIndex:indexPath.row];
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AccountInfoViewController *infoVC  = [story instantiateViewControllerWithIdentifier:@"AccountInfoViewController"];
    infoVC.user = answer.answerer;
    [self pushViewController:infoVC];
}


@end
