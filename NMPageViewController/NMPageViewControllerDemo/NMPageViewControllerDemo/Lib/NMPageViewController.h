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

/**
 * 显示视图
 */
@property (strong, nonatomic) NSArray * viewControllersArray;

/**
 *  顶部按钮显示的标题的数组
 */
@property (strong, nonatomic) NSArray * segmentTitleArray;

/**
 *  顶部按钮的数组,可以通过该数组对立面的btn进行修改，比如修改字体大小
 */
@property (strong, nonatomic ,readonly) NSMutableArray<UIButton *> * segmentBtnArray;

/**
 *  当前显示的控制器页数，从0开始
 */
@property (assign, nonatomic, readonly) NSInteger currentPage;

/**
 *  segment按钮高亮颜色,为nil默认为橘黄色
 */
@property (strong, nonatomic) UIColor *btnHighLightColor;

/**
 *  segment按钮非高亮颜色，为nil默认为灰色
 */
@property (strong, nonatomic) UIColor *btnNomalColor;

/**
 *  滚动动画，默认为NO
 */
@property (assign, nonatomic) BOOL scrollAnimation;

/**
 *  背景view,可以更改背景颜色等
 */

@property (strong, nonatomic , readonly) UIView * backgroundView;

/**
 *  小滑块视图，可以更改颜色,是否隐藏等属性
 */
@property (weak, nonatomic) IBOutlet UIView *slidingBlockView;

/**
 *  是否隐藏小滑块,默认是不隐藏
 */

@property (assign, nonatomic) BOOL isHideSlidingBlock;


@end
