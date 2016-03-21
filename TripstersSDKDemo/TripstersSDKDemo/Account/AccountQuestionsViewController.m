//
//  AccountQuestionsViewController.m
//  TripstersSDKDemo
//
//  Created by TimTiger on 16/3/1.
//  Copyright © 2016年 Tripsters. All rights reserved.
//

#import "AccountQuestionsViewController.h"
#import "AnswerListViewController.h"
#import "QPSApi.h"
#import "QuestionTableViewCell.h"
#import "AccountOtherInfoViewController.h"

@interface AccountQuestionsViewController () <QuestionTableViewCellDelegate>

@property (nonatomic,strong) QPSUserQuestionListReq *request;

@end

@implementation AccountQuestionsViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)initData {
    [super initData];
    self.request = [[QPSUserQuestionListReq alloc] init];
    self.request.user = self.user;
}

- (void)initView {
    [super initView];
    [self setLeftItemWithTitle:@"返回"];
}

- (void)requestData {
    self.request.page = self.tableView.page;
    [QPSApi getUserQuestionListWithReq:self.request success:^(QPSUserQuestionListReq *req, NSArray *responseObject) {
        [self refreshDataWithArray:responseObject];
    } failure:^(QPSUserQuestionListReq *req, NSError *error) {
        [self refreshDataWithArray:[NSArray new]];
    }];
}

#pragma mark - Actions
- (void)onLeftItemAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    QPSQuestion *question = [self.dataArray objectAtIndex:indexPath.row];
    return [QuestionTableViewCell heightWithQuestion:question cellWidth:self.view.bounds.size.width];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CountryCellIdentifier";
    QuestionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[QuestionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.delegate = self;
    QPSQuestion *question = [self.dataArray objectAtIndex:indexPath.row];
    [cell setCellWithQuestion:question];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AnswerListViewController *answerList = [[AnswerListViewController alloc] init];
    QPSQuestion *question = [self.dataArray objectAtIndex:indexPath.row];
    answerList.question = question;
    [self pushViewController:answerList];
}

- (void)cellUserInfoDidSelected:(QuestionTableViewCell *)cell {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    QPSQuestion *question = [self.dataArray objectAtIndex:indexPath.row];
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
    AccountOtherInfoViewController *infoVC  = [story instantiateViewControllerWithIdentifier:@"AccountOtherInfoViewController"];
    infoVC.user = question.asker;
    [self pushViewController:infoVC];
}

@end
