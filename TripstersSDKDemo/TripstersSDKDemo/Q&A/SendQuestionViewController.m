//
//  SendQuestionViewController.m
//  TripstersSDKDemo
//
//  Created by TimTiger on 16/2/26.
//  Copyright © 2016年 Tripsters. All rights reserved.
//

#import "SendQuestionViewController.h"
#import "UIViewController+Extension.h"
#import "QPSApi.h"
#import "LocationManager.h"
#import "Macro.h"
#import "NSArray+Extension.h"
#import "CityListViewController.h"

@interface SendQuestionViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,strong) QPSSendQuestionReq *request;
@end

@implementation SendQuestionViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftItemWithTitle:@"返回"];
    [self setRightItemWithTitle:@"发送"];
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 0;
    
    self.request = [[QPSSendQuestionReq alloc] init];
    self.request.country = self.country;
    
    [self addNotificationObserver];
}

#pragma mark - Notification
- (void)addNotificationObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handNotification:) name:CITYSELECTED object:nil];
}

- (void)removeNotificationObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)handNotification:(NSNotification *)notification {
    if ([notification.name isEqualToString:CITYSELECTED]) {
        NSArray *citys = (NSArray *)notification.object;
        if ([NSArray hasContent:citys]) {
            self.request.citys = citys;
            NSMutableString *citysString = [NSMutableString string];
            for (QPSCity *tcity in citys) {
                [citysString appendFormat:@"%@ ",tcity.chineseName];
            }
            self.cityLabel.text = citysString;
        }
    }
}

#pragma mark - Actions
- (void)onLeftItemAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onRightItemAction:(UIButton *)sender {
    self.request.imageData = UIImageJPEGRepresentation(self.imageView.image, 0.3);
    self.request.text = self.textView.text;
    [QPSApi sendQuestionWithReq:self.request success:^(QPSSendQuestionReq *req, NSString *questionID) {
        [[NSNotificationCenter defaultCenter] postNotificationName:QUESTIONSENDSUCCESS object:nil];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(QPSSendQuestionReq *req, NSError *error) {
        [self showNotificationWithText:error.localizedDescription];
    }];
}

- (IBAction)addImageAction:(id)sender {
    
    if (self.imageView.image != nil) {
        self.imageView.image = nil;
    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePicker animated:YES completion:^{
        
    }];
}

#pragma mark - DataSource and Delgate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    if (indexPath.row == 1) {
        CityListViewController *cityList = [[CityListViewController alloc] init];
        cityList.country = self.request.country;
        [self pushViewController:cityList];
    } else if (indexPath.row == 2) {
        
        if (self.request.placeMark != nil) {
            self.locationLabel.text = @"所在位置(可选)";
            self.request.placeMark = nil;
            return;
        }
        
        self.locationLabel.text = @"定位中...";
        [LocationManager getLocationWithCompletionHandler:^(CLPlacemark *placeMark, NSError *error) {
            NSLog(@"%@",placeMark.name);
            if (error == nil) {
                self.request.placeMark = placeMark;
                self.locationLabel.text = placeMark.name;
            } else {
                self.request.placeMark = nil;
                self.locationLabel.text = @"定位失败";
            }
        }];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    [self dismissViewControllerAnimated:YES completion:^{
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        self.imageView.image = image;
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


@end
