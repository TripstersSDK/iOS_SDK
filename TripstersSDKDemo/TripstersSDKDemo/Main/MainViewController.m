//
//  MainViewController.m
//  TripstersSDKDemo
//
//  Created by TimTiger on 16/2/25.
//  Copyright © 2016年 Tripsters. All rights reserved.
//

#import "MainViewController.h"
#import "QuestionListViewController.h"

@interface MainViewController ()

@property (nonatomic,strong) QuestionListViewController *questionVC;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.questionVC = [[QuestionListViewController alloc] init];

    self.questionVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"问答" image:[UIImage imageNamed:@"qa_tab_normal.png"] selectedImage:[UIImage imageNamed:@"qa_tab_hightlight.png"]];
    UINavigationController *qNavi = [[UINavigationController alloc] initWithRootViewController:self.questionVC];
    
    self.tabBar.tintColor = [UIColor grayColor];
    [self setViewControllers:@[qNavi]];
    
    [[self.tabBar.items objectAtIndex:0] setTitle:@"问答"];
}

@end
