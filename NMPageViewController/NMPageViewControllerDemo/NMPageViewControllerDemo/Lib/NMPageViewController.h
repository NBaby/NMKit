//
//  NMPageViewController.h
//  NMPageViewControllerDemo
//
//  Created by nuomi on 16/9/11.
//  Copyright © 2016年 nuomi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NMPageViewController : UIViewController
/**
 *  顶部按钮视图
 */
@property (weak, nonatomic) IBOutlet UIView *segmentView;
/**
 *  顶部视图高度数值
 */
@property (assign, nonatomic) float segmentViewHeight;
@end
