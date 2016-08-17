//
//  PZHSingleLabelViewController.m
//  PZHAutoLayoutDemo
//
//  Created by nuomi on 16/7/5.
//  Copyright © 2016年 nuomi. All rights reserved.
//

#import "PZHSingleLabelViewController.h"
#import "PZHSingleLabelShowController.h"
@implementation PZHSingleLabelViewController
#pragma mark - lifeCircle
- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.title = @"修改内容";
}
#pragma mark - UITableViewDelegate

#pragma mark - custonDelegate

#pragma mark - PriVateMethod

#pragma mark - EventResponse
#pragma mark 点击修改按钮
- (IBAction)tapBtn:(id)sender {
    PZHSingleLabelShowController * controller = [[PZHSingleLabelShowController alloc] init];
    controller.cellContentStr = _inputTextField.text;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - Network

#pragma mark - getter & setter
@end
