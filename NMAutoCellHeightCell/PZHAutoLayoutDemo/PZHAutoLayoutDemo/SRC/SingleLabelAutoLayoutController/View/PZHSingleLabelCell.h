//
//  PZHSingleLabelCell.h
//  PZHAutoLayoutDemo
//
//  Created by nuomi on 16/7/5.
//  Copyright © 2016年 nuomi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NMAutoHeightTableCell.h"
@interface PZHSingleLabelCell : NMAutoHeightTableCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end
@interface UITableView(PZHSingleLabelCell)
- (PZHSingleLabelCell*)PZHSingleLabelCell;
@end