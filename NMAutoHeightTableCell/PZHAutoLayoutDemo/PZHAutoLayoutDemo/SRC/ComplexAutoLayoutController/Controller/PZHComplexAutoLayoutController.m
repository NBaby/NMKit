//
//  PZHComplexAutoLayoutController.m
//  PZHAutoLayoutDemo
//
//  Created by nuomi on 16/7/5.
//  Copyright © 2016年 nuomi. All rights reserved.
//

#import "PZHComplexAutoLayoutController.h"
#import "PZHComplexAutoLayoutCell.h"
#import "PZHItemModel.h"
@interface PZHComplexAutoLayoutController (){
   ///数据源
    NSMutableArray <PZHItemModel *>*dataArray;
}

@end

@implementation PZHComplexAutoLayoutController
#pragma mark - lifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    dataArray = [[NSMutableArray alloc]init];
    for (int i= 0 ; i < 5; i ++) {
        PZHItemModel * model = [[PZHItemModel alloc]init];
        //可以修改这里的数据，来查看cell的变化
        model.title = [NSString stringWithFormat:@"我是主标题：%d",i];
        model.subTitle = [NSString stringWithFormat:@"我是副标题：%d",i];
        model.descStr =@"备注备注备注备注备注备注备注备注备注备注备注备注备注备注备注备注备注备注备注备注备注备注备注备注备注";
        [dataArray addObject:model];
    }
}
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PZHComplexAutoLayoutCell * cell = (PZHComplexAutoLayoutCell *)[tableView nm_customCellWithCellName:@"PZHComplexAutoLayoutCell"];
    [cell setInfo:dataArray[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
       PZHComplexAutoLayoutCell * cell = (PZHComplexAutoLayoutCell *)[tableView nm_customCellWithCellName:@"PZHComplexAutoLayoutCell"];
   float height =  [cell getHeightWidthInfo:dataArray[indexPath.row]];
    return height;
}
#pragma mark - custonDelegate

#pragma mark - PriVateMethod

#pragma mark - EventResponse

#pragma mark - Network

#pragma mark - getter & setter
@end
