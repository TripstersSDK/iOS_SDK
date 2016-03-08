//
//  AccountReceivedViewController.m
//  TripstersSDKDemo
//
//  Created by TimTiger on 16/3/1.
//  Copyright © 2016年 Tripsters. All rights reserved.
//

#import "AccountReceivedViewController.h"
#import "AnswerTableViewCell.h"
#import "AnswerListViewController.h"
#import "QPSApi.h"
#import "AccountInfoViewController.h"

@interface AccountReceivedViewController () <AnswerTableViewCellDelegate>
@property (nonatomic,strong) QPSUserReceivedAnswerListReq *request;
@end

@implementation AccountReceivedViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)initData {
    [super initData];
    self.request = [[QPSUserReceivedAnswerListReq alloc] init];
}

- (void)initView {
    [super initView];
    self.title = @"收到的回复";
    [self setLeftItemWithTitle:@"返回"];
}

- (void)requestData {
    self.request.page = self.tableView.page;
    [QPSApi getUserReceivedAnswerListWithReq:self.request success:^(QPSUserReceivedAnswerListReq *req, NSArray *responseObject) {
        [self refreshDataWithArray:responseObject];
    } failure:^(QPSUserReceivedAnswerListReq *req, NSError *error) {
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AnswerListViewController *answerList = [[AnswerListViewController alloc] init];
    QPSAnswer *answer = [self.dataArray objectAtIndex:indexPath.row];
    QPSQuestion *question = [QPSQuestion new];
    question.questionID = answer.questionID;
    answerList.question = question;
    [self pushViewController:answerList];
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
