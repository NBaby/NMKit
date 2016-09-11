//
//  NMPageViewController.m
//  NMPageViewControllerDemo
//
//  Created by nuomi on 16/9/11.
//  Copyright © 2016年 nuomi. All rights reserved.
//

#import "NMPageViewController.h"


@interface NMPageViewController (){
    UIPageViewController * mainPageViewController;
}
/**
 *  顶部按钮视图高度约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *segmentHeightConstraint;
@end

@implementation NMPageViewController

#pragma mark - lifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildPageView];
}
#pragma mark - UITableViewDelegate

#pragma mark - custonDelegate

#pragma mark - PriVateMethod
#pragma mark 构造pageView
- (void)buildPageView{
    mainPageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
}
#pragma mark - EventResponse

#pragma mark - Network

#pragma mark - getter & setter
- (void)setSegmentViewHeight:(float)segmentViewHeight{
    _segmentViewHeight = segmentViewHeight;
    _segmentHeightConstraint.constant = segmentViewHeight;
    
}
@end
