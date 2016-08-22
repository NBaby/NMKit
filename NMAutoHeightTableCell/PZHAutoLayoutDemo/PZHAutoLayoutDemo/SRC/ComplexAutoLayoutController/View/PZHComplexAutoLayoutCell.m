//
//  PZHComplexAutoLayoutCell.m
//  PZHAutoLayoutDemo
//
//  Created by nuomi on 16/7/5.
//  Copyright © 2016年 nuomi. All rights reserved.
//

#import "PZHComplexAutoLayoutCell.h"
#import "PZHItemModel.h"
@interface PZHComplexAutoLayoutCell(){
    PZHItemModel * dataModel;
}
@end
@implementation PZHComplexAutoLayoutCell

- (void)awakeFromNib {
    [super awakeFromNib];
    float screenWidth = [UIScreen mainScreen].bounds.size.width;
    CALayer * line = [[CALayer alloc]init];
    line.backgroundColor = [UIColor blackColor].CGColor;
    line.frame = CGRectMake(0, 0, screenWidth, 0.5);
    [self.contentView.layer addSublayer:line];
    
    _titleLabel.preferredMaxLayoutWidth = screenWidth-320+236;
    _subTitleLabel.preferredMaxLayoutWidth =screenWidth-320+236;
    _remarkLabel.preferredMaxLayoutWidth = screenWidth - 320 + 192;
    
}

- (void)setInfo:(id)info{
    dataModel = info;
    _titleLabel.text = dataModel.title;
    _subTitleLabel.text = dataModel.subTitle;
    _remarkLabel.text = dataModel.descStr;
    
}

@end
