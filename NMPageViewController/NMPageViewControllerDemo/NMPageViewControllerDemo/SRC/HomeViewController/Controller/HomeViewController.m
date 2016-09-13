//
//  HomeViewController.m
//  NMPageViewControllerDemo
//
//  Created by nuomi on 16/9/11.
//  Copyright © 2016年 nuomi. All rights reserved.
//

#import "HomeViewController.h"
#import "SubPageController.h"
#import "NMPageViewController.h"
#import "Masonry.h"
@interface HomeViewController ()<NMPageViewControllerDelegate>{
    NMPageViewController * pageViewController;
}

@end

@implementation HomeViewController

#pragma mark - lifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationController];
    
    NSMutableArray * mutableArray = [[NSMutableArray alloc]init];
    SubPageController * redController = [[SubPageController alloc]init];
    redController.color = [UIColor redColor];
    [mutableArray addObject:redController];
    
    SubPageController * blueController = [[SubPageController alloc]init];
    blueController.color = [UIColor blueColor];
    [mutableArray addObject:blueController];
    
    SubPageController * greenController = [[SubPageController alloc]init];
    greenController.color = [UIColor greenColor];
    [mutableArray addObject:greenController];
    
    SubPageController * blackController = [[SubPageController alloc]init];
    blackController.color = [UIColor blackColor];
    [mutableArray addObject:blackController];
    
 
    pageViewController = [[NMPageViewController alloc]initWithTitles:@[@"红色",@"蓝色",@"绿色",@"黑色"] viewControllers:mutableArray delegate:self parentView:self.view];
    
    [pageViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
        make.bottom.equalTo(self.view);
    }];

}

#pragma mark - UITableViewDelegate

#pragma mark - custonDelegate

#pragma mark - PriVateMethod
- (void)initNavigationController{
    self.navigationItem.title = @"标题";
}
#pragma mark - EventResponse

#pragma mark - Network

#pragma mark - getter & setter


@end
