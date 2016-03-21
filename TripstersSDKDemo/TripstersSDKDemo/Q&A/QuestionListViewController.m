//
//  QuestionListViewController.m
//  TripstersSDKDemo
//
//  Created by TimTiger on 16/2/20.
//  Copyright © 2016年 Tripsters. All rights reserved.
//

#import "QuestionListViewController.h"
#import "CountryListViewController.h"
#import "SendQuestionViewController.h"
#import "AnswerListViewController.h"
#import "NSString+Extension.h"
#import "EGOTableView.h"
#import "QPSApi.h"
#import "Macro.h"
#import "QPSApiObject+Extension.h"
#import "NSDictionary+Extension.h"
#import "QuestionTableViewCell.h"
#import "AccountOtherInfoViewController.h"

@interface QuestionListViewController () <EGOTableViewDelegate,QuestionTableViewCellDelegate>

@property (nonatomic,strong) QPSQuestionListReq *request;

@end

@implementation QuestionListViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)initData {
    [super initData];
    //初始化请求
    self.request = [[QPSQuestionListReq alloc] init];
    NSDictionary *countryDic = [[NSUserDefaults standardUserDefaults] objectForKey:SelectCountry];
    if ([NSDictionary hasContent:countryDic]) {
        QPSCountry *country = [QPSCountry countryWithDictionary:countryDic];
        self.request.country = country;
    }
    [self addNotificationObserver];
}

- (void)initView {
    [super initView];
    
    //底部提问按钮
    UIButton *sendQuestionButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-44, self.view.bounds.size.width, 44)];
    [sendQuestionButton setTitle:@"提问" forState:UIControlStateNormal];
    [sendQuestionButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    sendQuestionButton.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [sendQuestionButton addTarget:self action:@selector(sendQuestion) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendQuestionButton];
    
    [self setRightItemWithTitle:@"目的地"];
    [self setLeftItemWithTitle:@"返回"];
    
    //如果从未选过目的地，跳转先去选取目的地
    if (self.request.country == nil) {
        CountryListViewController *countryListVC = [[CountryListViewController alloc] init];
        countryListVC.hiddenBackItem = YES;
        [self pushViewController:countryListVC];
    } else {
        self.title = self.request.country.chineseName;
    }
}

- (void)requestData {
    self.request.page = self.tableView.page;
    [QPSApi getQuestionListWithReq:self.request success:^(QPSQuestionListReq *req, NSArray *responseObject) {
        [self refreshDataWithArray:responseObject];
    } failure:^(QPSQuestionListReq *req, NSError *error) {
        [self refreshDataWithArray:[NSArray new]];
    }];
}

- (void)dealloc
{
    [self removeNotificationObserver];
}

#pragma mark - Notification
- (void)addNotificationObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:COUNTRYCHANGED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:QUESTIONSENDSUCCESS object:nil];
}

- (void)removeNotificationObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)handleNotification:(NSNotification *)notification {
    if ([notification.name isEqualToString:COUNTRYCHANGED]) {
        if ((QPSCountry *)notification.object != nil) {
            self.request.country = (QPSCountry *)notification.object;
            self.navigationItem.title = self.request.country.chineseName;
            [self reloadData];
        }
    } else if ([notification.name isEqualToString:QUESTIONSENDSUCCESS]) {
        [self reloadData];
    }
}

#pragma mark - Actions
- (void)onLeftItemAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onRightItemAction:(UIButton *)sender {
    CountryListViewController *countryListVC = [[CountryListViewController alloc] init];
    [self pushViewController:countryListVC];
}

- (void)sendQuestion {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
    SendQuestionViewController *sendQuestionVC = [story instantiateViewControllerWithIdentifier:@"SendQuestionViewController"];
    sendQuestionVC.country = self.request.country;
    [self pushViewController:sendQuestionVC];
}

#pragma mark - Delegate
//MARK: - DataSource and Delgate
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
