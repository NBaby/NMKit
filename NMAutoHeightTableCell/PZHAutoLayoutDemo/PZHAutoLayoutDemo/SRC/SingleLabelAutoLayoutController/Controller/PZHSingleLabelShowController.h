//
//  PZHSingleLabelShowController.h
//  PZHAutoLayoutDemo
//
//  Created by nuomi on 16/7/5.
//  Copyright © 2016年 nuomi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PZHSingleLabelShowController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
///上级界面传入的cell的内容
@property (nonatomic, copy) NSString * cellContentStr;
@end
