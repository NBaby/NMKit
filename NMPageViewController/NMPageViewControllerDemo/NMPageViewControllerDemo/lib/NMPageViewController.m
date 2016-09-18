//
//  NMPageViewController.m
//  NMPageViewControllerDemo
//
//  Created by nuomi on 16/9/11.
//  Copyright © 2016年 nuomi. All rights reserved.
//

#import "NMPageViewController.h"
#import "Masonry.h"




@interface NMPageViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource,UIScrollViewDelegate>{
    UIPageViewController * mainPageViewController;
    
    UIScrollView * scrollow;//pageViewController中的scrollView
    
    UIColor *btnHighLightColor;
    
    UIColor *btnNomalColor;
    
    double slidingBlockWidth;
    
    double screenWidth;
    ///目标页面
    NSInteger targetPage;
}

/**
 *  线
 */
@property (weak, nonatomic) IBOutlet UIView *segmentBottomLine;
/**
 *  线的高度
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineHeightConstraint;

/**
 *  顶部按钮视图高度约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *segmentHeightConstraint;

/**
 *  自己内部调用可以修改
 */
@property (assign, nonatomic) NSInteger currentPage;

/**
 *  小滑块的宽度约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *slidingBlockWidthConstraint;

/**
 *  小滑块的位置约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *slidingBlockCoordinateConstraint;

/**
 *  缓存title的长度，只有在NMSlipingBlockAnimation为NMSlipingBlockAnimationGradient时生效
 */
@property (strong, nonatomic) NSMutableArray* segmentTitleLengthArray;
@end


@implementation NMPageViewController
@synthesize btnHighLightColor,btnNomalColor;

#pragma mark - lifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    screenWidth = [UIScreen mainScreen].bounds.size.width;
    _lineHeightConstraint.constant = 0.5;
}

#pragma mark - UIPageViewControllerDelegate
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    if (_currentPage <= 0) {
        return nil;
    }
    else {
        
        return _viewControllersArray[_currentPage -1];
    }
    
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    if (_currentPage >= _viewControllersArray.count -1) {
        return nil;
    }
    else {
        
        return _viewControllersArray[_currentPage +1];
    }
}
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
   
    if (completed) {
        self.currentPage = [_viewControllersArray indexOfObject:[pageViewController viewControllers][0]];
        _segmentBtnArray[_currentPage].selected = YES;
    }
   
    if ([self.delegate respondsToSelector:@selector(pageViewController:didFinishAnimating:previousViewControllers:transitionCompleted:)]) {
        [self.delegate pageViewController:pageViewController didFinishAnimating:finished previousViewControllers:previousViewControllers transitionCompleted:completed];
    }
    
}



- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers{
    
    targetPage = [_viewControllersArray indexOfObject:pendingViewControllers[0]];
    if (scrollow == nil) {
        //获得scrollView控制权
        for (int i= 0 ; i < pageViewController.view.subviews.count; i++) {
            if ([pageViewController.view.subviews[i] isKindOfClass:[UIScrollView class]]) {
                scrollow =  pageViewController.view.subviews[i];
            }
        }
        scrollow.delegate = self;
    }
    if ([self.delegate respondsToSelector:@selector(pageViewController:willTransitionToViewControllers:)]) {
        [self.delegate pageViewController:pageViewController willTransitionToViewControllers:pendingViewControllers];
    }
}
#pragma mark - PriVateMethod
#pragma mark 初始化方法
- (instancetype)initWithTitles:(NSArray *)titleArray viewControllers:(NSArray *)viewControllerArray delegate:(id<NMPageViewControllerDelegate>) delegate parentView:(UIView *)view{
    self = [super init];
    if (self) {
        self.view.frame = view.bounds;
        [view addSubview:self.view];
        self.segmentTitleArray = titleArray;
        self.viewControllersArray = viewControllerArray;
        self.delegate = delegate;
    }
    return self;
}
#pragma mark 颜色渐变算法
- (UIColor *)mixColor1:(UIColor*)color1 color2:(UIColor *)color2 ratio:(CGFloat)ratio
{
    if(ratio > 1)
        ratio = 1;
    if (ratio < 0){
        ratio = 0;
    }
    const CGFloat * components1 = CGColorGetComponents(color1.CGColor);
    const CGFloat * components2 = CGColorGetComponents(color2.CGColor);
//    NSLog(@"ratio = %f",ratio);
    CGFloat r = components1[0]*ratio + components2[0]*(1-ratio);
    CGFloat g = components1[1]*ratio + components2[1]*(1-ratio);
    CGFloat b = components1[2]*ratio + components2[2]*(1-ratio);
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

#pragma mark 构造pageView
- (void)buildPageView{
    mainPageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    mainPageViewController.delegate = self;
    mainPageViewController.dataSource = self;
    
    [self.view addSubview:mainPageViewController.view];
    
    [mainPageViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.top.equalTo(self.segmentView.mas_bottom);
    }];
    
    if (_viewControllersArray.count > 0){
        if ([_viewControllersArray[_currentPage] isKindOfClass:[UIViewController class]]) {
            [mainPageViewController setViewControllers:@[_viewControllersArray[_currentPage]] direction:UIPageViewControllerNavigationDirectionForward animated:_scrollAnimation completion:nil];
        }
        else {
            NSLog(@"NMPageViewController: 当前viewControllersArray容器中不是控制器类型");
        }
    }
    else{
        NSLog(@"NMPageViewController: viewControllersArray的个数为空");
    }
}

- (void)buildSegmentView{
    
    for (int i= 0 ; i < _segmentTitleArray.count; i++) {
        [_segmentBtnArray[i] removeFromSuperview];
    }
    _segmentBtnArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < _segmentTitleArray.count; i++) {
        UIButton * segmentBtn = [[UIButton alloc]init];
        [_segmentView addSubview:segmentBtn];
        [segmentBtn setTitleColor:self.btnHighLightColor forState:UIControlStateSelected];
        [segmentBtn setTitleColor:self.btnNomalColor forState:UIControlStateNormal];
        segmentBtn.tag = i;
        [segmentBtn addTarget:self action:@selector(tapSegmentWithBtn:) forControlEvents:UIControlEventTouchUpInside];
        [segmentBtn setTitle:_segmentTitleArray[i] forState:UIControlStateNormal];
        [_segmentBtnArray addObject:segmentBtn];

        [segmentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0) {
                make.left.equalTo(_segmentView);
            }
            else {
                make.left.equalTo(_segmentBtnArray[i-1].mas_right);
            }
            if (i == _segmentTitleArray.count -1) {
                make.right.equalTo(_segmentView);
            }
            make.width.mas_equalTo(screenWidth /_segmentTitleArray.count);
            make.top.equalTo(_segmentView);
            
        }];
    }
    
    [self buildSlipingBlock];
}

- (void)buildSlipingBlock{
    if (self.slipingBlockAnimationType == NMSlipingBlockAnimationNomal) {
        if (_segmentTitleArray.count == 0) {
            slidingBlockWidth = 0;
        }
        else {
            slidingBlockWidth = screenWidth / _segmentTitleArray.count;
            _slidingBlockWidthConstraint.constant = screenWidth / _segmentBtnArray.count;
        }

    }
    else if (self.slipingBlockAnimationType == NMSlipingBlockAnimationGradient ){
        if (_segmentTitleArray.count == 0) {
            slidingBlockWidth = 0;
        }
        else {
            
            _segmentTitleLengthArray = [[NSMutableArray alloc]init];
            for (int i = 0; i < _segmentBtnArray.count; i++) {
                CGSize size = [_segmentBtnArray[i].titleLabel.text sizeWithAttributes:@{NSFontAttributeName:_segmentBtnArray[i].titleLabel.font}];
                double length = size.width;
                if (length > screenWidth / _segmentBtnArray.count) {
                    length = screenWidth / _segmentBtnArray.count;
                }
                [_segmentTitleLengthArray addObject:@(length)];
            }
            _slidingBlockWidthConstraint.constant = [_segmentTitleLengthArray[_currentPage] doubleValue];
        }
        
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    float offsetX = scrollow.contentOffset.x;
//    NSLog(@"x:%f",offsetX);
    if (offsetX - screenWidth > 0 && _currentPage < _segmentTitleArray.count - 1) {
        //向右移
        UIColor * curColor = [self mixColor1:self.btnNomalColor color2:self.btnHighLightColor ratio:(offsetX - screenWidth)/screenWidth ];
        _segmentBtnArray[_currentPage].selected = NO;
        [_segmentBtnArray[_currentPage] setTitleColor:curColor forState:UIControlStateNormal];
        
         UIColor * rightBtnColor = [self mixColor1:self.btnHighLightColor color2:self.btnNomalColor ratio:(offsetX - screenWidth)/screenWidth ];
        _segmentBtnArray[targetPage].selected = NO;
        [_segmentBtnArray[targetPage] setTitleColor:rightBtnColor forState:UIControlStateNormal];
        //小滑块位置调整
        _slidingBlockCoordinateConstraint.constant = (offsetX - screenWidth) * labs(targetPage - _currentPage) / self.segmentTitleArray.count + slidingBlockWidth/2 +  _currentPage * slidingBlockWidth - screenWidth/2;
        if (self.slipingBlockAnimationType == NMSlipingBlockAnimationGradient ) {
            double ratio = (offsetX - screenWidth)/screenWidth;
            double currentTitleWidth = [_segmentTitleLengthArray[_currentPage] doubleValue];
            double rightTitleWidth = [_segmentTitleLengthArray[targetPage] doubleValue];
            _slidingBlockWidthConstraint.constant = currentTitleWidth + (rightTitleWidth -currentTitleWidth)*ratio;
        }
    }
    else if (offsetX - screenWidth < 0 && _currentPage > 0){
        //向左移
        UIColor * curColor = [self mixColor1:self.btnNomalColor color2:self.btnHighLightColor ratio:(screenWidth -offsetX)/screenWidth ];
        _segmentBtnArray[_currentPage].selected = NO;
        [_segmentBtnArray[_currentPage] setTitleColor:curColor forState:UIControlStateNormal];
        
        UIColor * rightBtnColor = [self mixColor1:self.btnHighLightColor color2: self.btnNomalColor ratio:(screenWidth -offsetX)/screenWidth ];
        _segmentBtnArray[targetPage].selected = NO;
        [_segmentBtnArray[targetPage] setTitleColor:rightBtnColor forState:UIControlStateNormal];
        //小滑块位置调整
        _slidingBlockCoordinateConstraint.constant = (offsetX - screenWidth) * labs(targetPage - _currentPage)/ self.segmentTitleArray.count + slidingBlockWidth/2 + _currentPage * slidingBlockWidth - screenWidth/2;
        if (self.slipingBlockAnimationType == NMSlipingBlockAnimationGradient) {
            double ratio = (screenWidth - offsetX)/screenWidth;
            double currentTitleWidth = [_segmentTitleLengthArray[_currentPage] doubleValue];
            double leftTitleWidth = [_segmentTitleLengthArray[targetPage] doubleValue];
            
            _slidingBlockWidthConstraint.constant = currentTitleWidth + (leftTitleWidth -currentTitleWidth)*ratio;
        }


    }
    else if (offsetX - screenWidth == 0){
        //将左右两边恢复
        if (_currentPage - 1 >=0) {
             [_segmentBtnArray[_currentPage - 1] setTitleColor:btnNomalColor forState:UIControlStateNormal];
        }
        _segmentBtnArray[_currentPage ].selected = YES;
        [_segmentBtnArray[_currentPage ] setTitleColor:btnNomalColor forState:UIControlStateNormal];
        if (_currentPage + 1< _segmentBtnArray.count) {
             [_segmentBtnArray[_currentPage + 1] setTitleColor:btnNomalColor forState:UIControlStateNormal];
        }
        //小滑块位置调整
        _slidingBlockCoordinateConstraint.constant = (offsetX - screenWidth) / self.segmentTitleArray.count + slidingBlockWidth/2 + _currentPage * slidingBlockWidth - screenWidth/2;
        if (self.slipingBlockAnimationType == NMSlipingBlockAnimationGradient) {
            double currentTitleWidth = [_segmentTitleLengthArray[_currentPage] doubleValue];
            _slidingBlockWidthConstraint.constant = currentTitleWidth ;
        }
        
    }
  
    if ([self.delegate respondsToSelector:@selector(pageViewDidScroll:)]) {
        [self.delegate pageViewDidScroll:scrollow];
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

    if ([self.delegate respondsToSelector:@selector(pageViewWillBeginDragging:)]) {
        [self.delegate pageViewWillBeginDragging:scrollow];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    if ([self.delegate respondsToSelector:@selector(pageViewDidEndScrollingAnimation:)]) {
        [self.delegate pageViewDidEndScrollingAnimation:scrollow];
    }

}
#pragma mark - EventResponse
#pragma mark 点击segment按钮
- (void)tapSegmentWithBtn:(UIButton *)btn{
    if (scrollow ==  nil) {
        //获得scrollView控制权
        for (int i= 0 ; i < mainPageViewController.view.subviews.count; i++) {
            if ([mainPageViewController.view.subviews[i] isKindOfClass:[UIScrollView class]]) {
                scrollow =  mainPageViewController.view.subviews[i];
            }
        }
        scrollow.delegate = self;
    }
    targetPage = btn.tag;
    if (btn.tag < _viewControllersArray.count) {
        __weak typeof(self) wSelf= self;
        //只有按钮个数小于Controller个数的前提下，点击才生效
        if (_currentPage < btn.tag) {
            
           
            [mainPageViewController setViewControllers:@[_viewControllersArray[btn.tag]] direction:UIPageViewControllerNavigationDirectionForward animated:_scrollAnimation completion:^(BOOL finished) {
                if (finished) {
                    [wSelf setCurrentPage:btn.tag];

                }
            }];
           
            
        }
        else {
            
            [mainPageViewController setViewControllers:@[_viewControllersArray[btn.tag]] direction: UIPageViewControllerNavigationDirectionReverse  animated:_scrollAnimation completion:^(BOOL finished) {
                if (finished) {
                    [wSelf setCurrentPage:btn.tag];
                }
                
            }];
            
            
        }
       
       
    }
}
#pragma mark - Network

#pragma mark - getter & setter
- (void)setSegmentViewHeight:(float)segmentViewHeight{
    _segmentViewHeight = segmentViewHeight;
    _segmentHeightConstraint.constant = segmentViewHeight;
    
}

- (void)setViewControllersArray:(NSArray *)viewControllersArray {
    if ([_viewControllersArray isEqualToArray:viewControllersArray]) {
        return ;
    }
    _viewControllersArray = viewControllersArray;
    self.currentPage = 0;
    [mainPageViewController.view removeFromSuperview];
    [self buildPageView];
}

- (void)setSegmentTitleArray:(NSArray *)segmentTitleArray{
    if ([_segmentTitleArray isEqualToArray:segmentTitleArray]) {
        return;
    }
    _segmentTitleArray = segmentTitleArray;
    [self buildSegmentView];
}


- (UIColor *)btnNomalColor{
    if (btnNomalColor == nil) {
        btnNomalColor = [UIColor colorWithRed:139/255.0 green:139/255.0 blue:139.0/255 alpha:1];
    }
    return btnNomalColor;
}

- (void)setBtnNomalColor:(UIColor *)newBtnNomalColor{
    btnNomalColor = newBtnNomalColor;
    for (int i = 0; i < _segmentBtnArray.count; i++) {
        UIButton * segmentBtn = _segmentBtnArray[i];
        [segmentBtn setTitleColor:btnNomalColor forState:UIControlStateNormal];
    }
}

- (UIColor *)btnHighLightColor{
    if (btnHighLightColor == nil) {
        btnHighLightColor = [UIColor colorWithRed:253/255.0 green:128/255.0 blue:0 alpha:1];
    }
    return btnHighLightColor;
}

- (void)setBtnHighLightColor:(UIColor *)newBtnHighLightColor{
    btnHighLightColor = newBtnHighLightColor;
    for (int i = 0; i < _segmentBtnArray.count; i++) {
        UIButton * segmentBtn = _segmentBtnArray[i];
        [segmentBtn setTitleColor:btnHighLightColor forState:UIControlStateSelected];
    }
}

- (void)setCurrentPage:(NSInteger)currentPage{
    _segmentBtnArray [_currentPage].selected = NO;
    _currentPage = currentPage;
    _segmentBtnArray [_currentPage].selected = YES;
   
    _slidingBlockCoordinateConstraint.constant = slidingBlockWidth/2 + _currentPage * slidingBlockWidth - screenWidth/2;
    if (self.slipingBlockAnimationType == NMSlipingBlockAnimationGradient) {
        double width = [_segmentTitleLengthArray[_currentPage ] doubleValue];
        _slidingBlockWidthConstraint.constant = width;
    }
}

- (UIView *)backgroundView{
    return self.view;
}

-(void)setIsHideSlidingBlock:(BOOL)isHideSlidingBlock{
    _isHideSlidingBlock = isHideSlidingBlock;
    _slidingBlockView.hidden = isHideSlidingBlock;
}

- (void)setSlipingBlockAnimationType:(NMSlipingBlockAnimation)slipingBlockAnimationType{
    if (_slipingBlockAnimationType != slipingBlockAnimationType) {
        _slipingBlockAnimationType = slipingBlockAnimationType;
        [self buildSlipingBlock];
    }
}

@end
