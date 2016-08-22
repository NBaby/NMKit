//
//  PZHSingleLabelShowController.m
//  PZHAutoLayoutDemo
//
//  Created by nuomi on 16/7/5.
//  Copyright © 2016年 nuomi. All rights reserved.
//

#import "PZHSingleLabelShowController.h"
#import "PZHSingleLabelCell.h"
@interface PZHSingleLabelShowController ()

@end

@implementation PZHSingleLabelShowController
#pragma mark - lifeCircle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"显示界面";
  
}
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PZHSingleLabelCell * cell = (PZHSingleLabelCell *)[tableView nm_customCellWithCellName:@"PZHSingleLabelCell"];
    [cell setInfo:_cellContentStr];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    PZHSingleLabelCell * cell = (PZHSingleLabelCell *)[tableView nm_customCellWithCellName:@"PZHSingleLabelCell"];
   return  [cell getHeightWidthInfo:_cellContentStr];
}
#pragma mark - custonDelegate

#pragma mark - PriVateMethod

#pragma mark - EventResponse

#pragma mark - Network

#pragma mark - getter & setter

@end
