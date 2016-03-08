//
//  SendReAnswerViewController.m
//  TripstersSDKDemo
//
//  Created by TimTiger on 16/3/1.
//  Copyright © 2016年 Tripsters. All rights reserved.
//

#import "SendReAnswerViewController.h"
#import "UIViewController+Extension.h"
#import "QPSApi.h"
#import "LocationManager.h"
#import "Macro.h"
#import "NSArray+Extension.h"
#import "CityListViewController.h"

@interface SendReAnswerViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,strong) QPSSendReAnswerReq *request;
@end


@implementation SendReAnswerViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"回复%@",self.answer.answerer.nickname];
    [self setLeftItemWithTitle:@"返回"];
    [self setRightItemWithTitle:@"发送"];
    self.tableView.sectionHeaderHeight = 0;
    
    self.request = [[QPSSendReAnswerReq alloc] init];
    self.request.question = self.question;
    self.request.recipient = self.answer.answerer;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}

#pragma mark - Actions
- (void)onLeftItemAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onRightItemAction:(UIButton *)sender {
    self.request.imageData = UIImageJPEGRepresentation(self.imageView.image, 0.3);
    self.request.text = self.textView.text;
    [QPSApi sendReAnswerWithReq:self.request success:^(QPSSendReAnswerReq *req, NSString *answerID) {
        [[NSNotificationCenter defaultCenter] postNotificationName:ANSWERSENDSUCCESS object:nil];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(QPSSendReAnswerReq *req, NSError *error) {
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
