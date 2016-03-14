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
#import "AccountInfoViewController.h"

@interface ViewController ()
@property (nonatomic,strong) NSArray *dataSource;
@property (nonatomic,readwrite) NSInteger unread;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib
    self.title = @"趣皮士SDK Demo";
    
    self.dataSource = @[@"问答",@"我的"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:NewAnswerRecivedNotification object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)handleNotification:(NSNotification *)notification {
    if (self.dataSource.count > 1) {
        self.dataSource = @[@"问答",@"我的(有新的回答)"];
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
        QuestionListViewController *questionList = [[QuestionListViewController alloc] init];
        [self.navigationController pushViewController:questionList animated:YES];
    } else if (indexPath.row == 1) {
        self.dataSource = @[@"问答",@"我的"];
        [self.tableView reloadData];
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        AccountInfoViewController *infoVC  = [story instantiateViewControllerWithIdentifier:@"AccountInfoViewController"];
        [self.navigationController pushViewController:infoVC animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
