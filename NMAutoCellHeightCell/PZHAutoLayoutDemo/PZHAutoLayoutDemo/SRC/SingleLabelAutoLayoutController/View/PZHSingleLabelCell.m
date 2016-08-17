//
//  PZHSingleLabelCell.m
//  PZHAutoLayoutDemo
//
//  Created by nuomi on 16/7/5.
//  Copyright © 2016年 nuomi. All rights reserved.
//

#import "PZHSingleLabelCell.h"

@implementation PZHSingleLabelCell

- (void)awakeFromNib {
    [super awakeFromNib];
    ///告诉系统，_titleLabel一行有多少宽
    _titleLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 320 + 304;
}

- (void)setInfo:(id)info{
    _titleLabel.text = info;
}

@end
@implementation  UITableView(PZHSingleLabelCell)

- (PZHSingleLabelCell *)PZHSingleLabelCell {
    static NSString *CellIdentifier = @"PZHSingleLabelCell";
    PZHSingleLabelCell *Cell=(PZHSingleLabelCell *)[self dequeueReusableCellWithIdentifier:CellIdentifier];
    if(nil==Cell) {
        UINib *nib = [UINib nibWithNibName:CellIdentifier bundle:nil];
        [self registerNib:nib forCellReuseIdentifier:CellIdentifier];
        Cell = (PZHSingleLabelCell *)[self dequeueReusableCellWithIdentifier:CellIdentifier];
    }
    Cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return Cell;
}
@end