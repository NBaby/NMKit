//
//  NMAutoHeightTableCell.m
//  PZHAutoLayoutDemo
//
//  Created by nuomi on 16/7/5.
//  Copyright © 2016年 nuomi. All rights reserved.
//

#import "NMAutoHeightTableCell.h"

@implementation NMAutoHeightTableCell
- (void)awakeFromNib {
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
        self.contentView.preservesSuperviewLayoutMargins = NO;
    }
}
- (void)setInfo:(id)info{
    
    
}
- (CGFloat)getHeightWidthInfo:(id)info{
    [self setInfo:info];
    [self layoutSubviews];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    CGFloat height = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height ;
    return  height;
}
@end
