//
//  SendAnswerViewController.m
//  TripstersSDKDemo
//
//  Created by TimTiger on 16/2/29.
//  Copyright © 2016年 Tripsters. All rights reserved.
//

#import "SendAnswerViewController.h"
#import "UIViewController+Extension.h"
#import "QPSApi.h"
#import "LocationManager.h"
#import "Macro.h"
#import "NSArray+Extension.h"
#import "CityListViewController.h"

@interface SendAnswerViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,strong) QPSSendAnswerReq *request;
@end

@implementation SendAnswerViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftItemWithTitle:@"返回"];
    [self setRightItemWithTitle:@"发送"];
    self.tableView.sectionHeaderHeight = 0;
    
    self.request = [[QPSSendAnswerReq alloc] init];
    self.request.question = self.question;
}

#pragma mark - Actions
- (void)onLeftItemAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onRightItemAction:(UIButton *)sender {
    self.request.imageData = UIImageJPEGRepresentation(self.imageView.image, 0.3);
    self.request.text = self.textView.text;
    [QPSApi sendAnswerWithReq:self.request success:^(QPSSendAnswerReq *req, NSString *answerID) {
        [[NSNotificationCenter defaultCenter] postNotificationName:ANSWERSENDSUCCESS object:nil];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(QPSSendAnswerReq *req, NSError *error) {
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
