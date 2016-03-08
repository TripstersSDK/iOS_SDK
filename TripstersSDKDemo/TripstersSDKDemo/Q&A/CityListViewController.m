//
//  CityListViewController.m
//  TripstersSDKDemo
//
//  Created by TimTiger on 16/2/29.
//  Copyright © 2016年 Tripsters. All rights reserved.
//

#import "CityListViewController.h"
#import "QPSApi.h"
#import "UIImageView+WebCache.h"
#import "Macro.h"

@interface CityListViewController ()

@property (nonatomic,strong) QPSCityListReq *request;
@property (nonatomic,readwrite) NSInteger selectCount;

@end

@implementation CityListViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)initData {
    [super initData];
    self.request = [[QPSCityListReq alloc] init];
    self.request.country = self.country;
    self.selectCount = 0;
}

- (void)initView {
    [super initView];
    self.title = self.country.chineseName;
    [self setLeftItemWithTitle:@"返回"];
    [self setRightItemWithTitle:@"确认"];
    self.tableView.showLoadMore = NO;
    [self.tableView setEditing:YES];
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
}

- (void)requestData {
    [QPSApi getCityListWithCityReq:self.request success:^(QPSCityListReq *req, NSArray *responseObject) {
        [self refreshDataWithArray:responseObject];
    } failure:^(QPSCityListReq *req, NSError *error) {
        [self refreshDataWithArray:[NSArray new]];
    }];
}

#pragma mark - Actions
- (void)onLeftItemAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onRightItemAction:(UIButton *)sender {
    NSMutableArray *selectCitys = [NSMutableArray arrayWithCapacity:0];
    for (QPSCity *city in self.dataArray) {
        if ([city isSelected]) {
            [selectCitys addObject:city];
        }
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:CITYSELECTED object:selectCitys];
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
    QPSCity *city = [self.dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = city.chineseName;
    if ([city isHot]) {
        cell.textLabel.textColor = [UIColor blueColor];
    } else {
        cell.textLabel.textColor = [UIColor grayColor];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.selectCount > 1) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        return;
    }
    
    QPSCity *city = [self.dataArray objectAtIndex:indexPath.row];
    city.selected = YES;
    self.selectCount++;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    QPSCity *city = [self.dataArray objectAtIndex:indexPath.row];
    city.selected = NO;
    self.selectCount--;
}

@end
