#NMPageViewController
##前言
***
最近的项目很多页面都是UIPageViewController加上segment点击切换的界面结构。每次都重复写觉得真的很麻烦，因此抽出时间封装了一个NMPageViewController。先来看看效果：

* NMSlipingBlockAnimationGradientmo 模式

![NMSlipingBlockAnimationGradientmo模式](http://upload-images.jianshu.io/upload_images/2368050-8a3267635a199fa5.gif?imageMogr2/auto-orient/strip)

* NMSlipingBlockAnimationNomal 模式

![NMSlipingBlockAnimationNomal模式](http://upload-images.jianshu.io/upload_images/2368050-bdf7075840f77074.gif?imageMogr2/auto-orient/strip)

##特性
***
* **生成简单**:初始化方便，一句代码就能生成pageView、segmentView和delegate。
* **适用性**:可以适应各种使用环境，不变形。
* **高性能**:正常使用情况下不掉帧。
* **易用**:支持修改按钮各项属性，修改segment高度，背景view颜色等。

##使用
***
###初始化
简单的初始化方法

	/**
	 *  初始化方法
	 *
	 *  @param titleArray          segment显示按钮标题数组
	 *  @param viewControllerArray pageViewController的子视图控制器
	 *  @param delegate 代理控制器
	 *  @param 父类视图View
	 *
	 *  @return NMPageViewController
	 */
	 - (instancetype)initWithTitles:(NSArray *)titleArray viewControllers:(NSArray *)viewControllerArray delegate:(id<NMPageViewControllerDelegate>) delegate parentView:(UIView *)view;
 	
###代理方法

	@protocol NMPageViewControllerDelegate <NSObject>
	@optional
	// Sent when a gesture-initiated transition begins.
	- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers NS_AVAILABLE_IOS(6_0);

	// Sent when a gesture-initiated transition ends. The 'finished' parameter indicates whether the animation finished, while the 'completed' parameter indicates whether the transition completed or bailed out (if the user let go early).
	- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed;
	/**
	 *  pageView滑动响应
	 *
	 *  @param scrollView pageView的ScrollView
	 */
	- (void)pageViewDidScroll:(UIScrollView *)scrollView;
	/**
	 *  pageView开始滑动响应
	 *
	 *  @param scrollView pageView的ScrollView
	 */
	- (void)pageViewWillBeginDragging:(UIScrollView *)scrollView;
	/**
	 *  pageView结束滑动响应
	 *
	 *  @param scrollView pageView的ScrollView
	 */
	- (void)pageViewDidEndScrollingAnimation:(UIScrollView *)scrollView;

	@end

 
###其他可更改属性

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

	/**
	 *  小滑块的动画样式
	 */
	@property (assign, nonatomic) NMSlipingBlockAnimation slipingBlockAnimationType;

##安装
***
* github:[https://github.com/NBaby/NMKit/tree/master/NMPageViewController](https://github.com/NBaby/NMKit/tree/master/NMPageViewController)

 
