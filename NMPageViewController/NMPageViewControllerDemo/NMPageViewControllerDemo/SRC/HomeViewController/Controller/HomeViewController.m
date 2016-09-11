//
//  HomeViewController.m
//  NMPageViewControllerDemo
//
//  Created by nuomi on 16/9/11.
//  Copyright © 2016年 nuomi. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

#pragma mark - lifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationController];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0.1f;
}
#pragma mark - custonDelegate

#pragma mark - PriVateMethod
- (void)initNavigationController{
    self.navigationItem.title = @"标题";
}
#pragma mark - EventResponse

#pragma mark - Network

#pragma mark - getter & setter


@end
