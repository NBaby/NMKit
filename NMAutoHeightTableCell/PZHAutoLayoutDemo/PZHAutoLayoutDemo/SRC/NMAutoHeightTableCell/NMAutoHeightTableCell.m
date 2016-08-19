//
//  NMAutoHeightTableCell.m
//  PZHAutoLayoutDemo
//
//  Created by nuomi on 16/7/5.
//  Copyright © 2016年 nuomi. All rights reserved.
//

#import "NMAutoHeightTableCell.h"
#import "objc/runtime.h"

@implementation NMAutoHeightTableCell
- (void)awakeFromNib {
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
        self.contentView.preservesSuperviewLayoutMargins = NO;
    }
}
- (void)setInfo:(id)info{
    
    
}
- (CGFloat)getHeightWidthInfo:(id)info{
    
    CGFloat height = [[self.nm_tableView.cellHeightCache objectForKey:@"1"] floatValue];
    if ( [[self.nm_tableView.cellHeightCache objectForKey:@"1"] floatValue]!=0) {
        return height;
    }
    
    [self setInfo:info];
    [self layoutSubviews];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    height = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height ;
    [self.nm_tableView.cellHeightCache setObject:@(height) forKey:@"1"];
    return  height;
}
@end

@implementation  UITableView(NMCustomTableView)

- (UITableViewCell *)customCellWithCellName:(NSString *)cellName {
   
    UITableViewCell *Cell=(UITableViewCell *)[self dequeueReusableCellWithIdentifier:cellName];
    if(nil==Cell) {
        UINib *nib = [UINib nibWithNibName:cellName bundle:nil];
        [self registerNib:nib forCellReuseIdentifier:cellName];
        Cell = (UITableViewCell *)[self dequeueReusableCellWithIdentifier:cellName];
        
    }
    Cell.nm_tableView = self;
    Cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return Cell;
}


- (void)setCellHeightCache:(NSMutableDictionary *)cellHeightCache {

    objc_setAssociatedObject(self, @selector(cellHeightCache), cellHeightCache, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)cellHeightCache {

    NSMutableDictionary * dic = objc_getAssociatedObject(self, @selector(cellHeightCache));
    if (dic== nil) {
        dic = [[NSMutableDictionary alloc]init];
        self.cellHeightCache = dic;
    }
    return dic;
}
@end

@implementation  UITableViewCell(NMCustomCell)

- (void)setNm_tableView:(UITableView *)nm_tableView{
    
     objc_setAssociatedObject(self, @selector(nm_tableView), nm_tableView, OBJC_ASSOCIATION_ASSIGN);
}
- (UITableView *)nm_tableView{
    
     return objc_getAssociatedObject(self, @selector(nm_tableView));
}
@end