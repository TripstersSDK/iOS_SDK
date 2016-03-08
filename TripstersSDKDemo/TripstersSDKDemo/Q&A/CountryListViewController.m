//
//  CountryListViewController.m
//  TripstersSDKDemo
//
//  Created by TimTiger on 16/2/20.
//  Copyright © 2016年 Tripsters. All rights reserved.
//

#import "CountryListViewController.h"
#import "QPSApi.h"
#import "UIImageView+WebCache.h"
#import "Macro.h"
#import "QPSApiObject+Extension.h"

@interface CountryListViewController () 

@property (nonatomic,strong) QPSCountryListReq *request;

@end

@implementation CountryListViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)initData {
    [super initData];
    self.request = [[QPSCountryListReq alloc] init];
}

- (void)initView {
    [super initView];
    self.title = @"切换目的地";
    [self.navigationItem setHidesBackButton:YES];
    if (self.hiddenBackItem == NO) {
        [self setLeftItemWithTitle:@"返回"];
    }
    self.tableView.showLoadMore = NO;
}

- (void)requestData {
    [QPSApi getCountryListWithBaseReq:self.request success:^(QPSCountryListReq *req, NSArray *responseObject) {
            [self refreshDataWithArray:responseObject];
        } failure:^(QPSCountryListReq *req, NSError *error) {
            [self refreshDataWithArray:[NSArray new]];
    }];
}

#pragma mark - Actions
- (void)onLeftItemAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Delegate
//MARK: - DataSource and Delgate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CountryCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    QPSCountry *country = [self.dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = country.chineseName;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:country.picUrlString] placeholderImage:nil];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    QPSCountry *country = [self.dataArray objectAtIndex:indexPath.row];
    [[NSUserDefaults standardUserDefaults] setObject:[country dictionary] forKey:SelectCountry];
    [[NSNotificationCenter defaultCenter] postNotificationName:COUNTRYCHANGED object:country];
    [self.navigationController popViewControllerAnimated:true];
}

@end
