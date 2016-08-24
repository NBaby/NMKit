
#使用AutoLayout自动计算可变cell高度
pods:`pod 'NMAutoHeightTableCell', '~> 0.1.3'`
###方案一：死计算（传统、麻烦）
这个方法应该大家都会，先摆放控件，然后根据Label里面的内容调用NSString的`sizeWithAttributes:@{NSFontAttributeName:font}`方法获得CGSize，然后根据CGSize累加高度，得出最后的高度。这个方法很普遍，但是如果控件多，Label的个数多，计算的代码就十分复杂，而且屏幕适配也有问题。
###方案二：AutoLayout实现自动计算（推荐）
其实，很多人不知道神奇的AutoLayout就能帮我们做很多事，计算cell高度当然不在话下。系统的UIView有这么一个方法`systemLayoutSizeFittingSize:`
官方文档的描述为:

    Return Value
    The size of the view that satisfies the constraints it     holds.

    Discussion
    Determines the best size of the view considering all constraints it holds and those of its subviews.

    Availability
    Available in iOS 6.0 and later.
总的来说，就是返回一个CGSize,如果UIView的frame的尺寸和这个size相同，就能正好满足所有约束。如果我们在tableView的代理`tableView:heightForRowAtIndexPath:`中返回这个size的height，不就能解决cell高度自动计算了么？没看懂？没关系，下面我们就来看看到底怎么实现。
##方案二的实现
***
首先我们要创建TableView、Cell,并设置代理，然后在cell上加上约束。用简单的UILabel举例，如图所示：
![EC2917D3-BCD0-40E8-A04D-BDD6D4F2A6B0.png](http://upload-images.jianshu.io/upload_images/2368050-7f448ce9e16a197b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
我在Label上下左右都加了约束。可能有人会问，3个约束就能确定Label的位置，为什么要添加4个约束呢？因为要使用AutoLayout实现自动计算高度，就必须用约束把View "撑开来"。我们把约束想象成“支撑杆”，那么上面的图我们用矩形来表示这个“支撑杆”

![21821646-4CDD-4038-905D-E4E57D85FC71.png](http://upload-images.jianshu.io/upload_images/2368050-318089acf3ae24bf.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

很容易看出，父类Cell被撑开，这样就满足使用`systemLayoutSizeFittingSize:`来获得cell的size。

下面设置Label的line为0，再在cell的`.m`文件中设置下UILabel每一行的宽度

    - (void)awakeFromNib {
        [super awakeFromNib];
        //告诉系统，_titleLabel一行有多少宽
        _titleLabel.preferredMaxLayoutWidth = UIlabel每一行的宽度;
     }
     
最后只要在ViewController里调用`systemLayoutSizeFittingSize:`方法获得高度，然后返回就好了。是不是很简单？
     
	- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        PZHComplexAutoLayoutCell * cell = [tableView PZHComplexAutoLayoutCell];
	  	float height =  [cell getHeightWidthInfo:dataArray[indexPath.row]];
                return height;
	}
		
	- (CGFloat)getHeightWidthInfo:(id)info{
        [self setInfo:info];
        [self layoutSubviews];
    
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
    
        [self setNeedsLayout];
        [self layoutIfNeeded];
        CGFloat height = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height ;
        return  height+1;
 //这里需要注意的是如果使用了系统tableView的线的话，要加1，如果没有用系统的线就不需要加1.
	}
##总结
* 设置约束将Cell“撑开来”
* 部分控件设置preferredMaxLayoutWidth属性，告诉每一行的最大值（大多数控件不需要）
* 调用 systemLayoutSizeFittingSize: 方法，获得CGSize,从而获得高度

##Show Me The Code!
github：
[https://github.com/NBaby/PZHDemoCollection](https://github.com/NBaby/PZHDemoCollection)
##结尾
虽然使用AutoLayout计算高度很方便，但是，还是要考虑性能的问题。如果cell复杂，每次在`- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath`中都计算高度，那么会有很大的资源浪费，这里建议做缓存，只要计算一次高度就缓存下来，下一次直接从缓存中取高度。至于怎么做缓存，仁者见仁，智者见智啦。

简书地址：[http://www.jianshu.com/p/069fe39b62c5](http://www.jianshu.com/p/069fe39b62c5)