//
//  NMAutoHeightTableCell.m
//  PZHAutoLayoutDemo
//
//  Created by nuomi on 16/7/5.
//  Copyright © 2016年 nuomi. All rights reserved.
//

#import "NMAutoHeightTableCell.h"
#import "objc/runtime.h"
#import "YYCache.h"
#import<CommonCrypto/CommonDigest.h> 
#import "YYModel.h"

@implementation NMAutoHeightTableCell
- (void)awakeFromNib {
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
        self.contentView.preservesSuperviewLayoutMargins = NO;
    }
}

/**
 * sha1加密
 */

- (NSString*) sha1:(id)info
{
    if (info == nil) {
        return @"";
    }
    NSData *data = [[info yy_modelToJSONString] dataUsingEncoding:NSUTF8StringEncoding];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (int)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

- (void)setInfo:(id)info{
    
    
}

- (CGFloat)getHeightWidthInfo:(id)info{
    
    NSString * infoHashStr  =  [self sha1:info];
    NSString * classNameStr = [NSString stringWithUTF8String:object_getClassName(self)];
    NSString * cacheKey = [NSString stringWithFormat:@"%@ + %@",classNameStr,infoHashStr];
    
    CGFloat height = [[self.nm_tableView.cellHeightCache objectForKey:cacheKey] floatValue];
    if ( [[self.nm_tableView.cellHeightCache objectForKey:cacheKey] floatValue]!=0) {
        return height;
    }
    
    [self setInfo:info];
    [self layoutSubviews];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    height = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height ;
    [self.nm_tableView.cellHeightCache setObject:@(height) forKey:cacheKey];
    
    if (self.nm_tableView.separatorStyle == UITableViewCellSeparatorStyleNone) {
        return height;
    }
    else {
        //如果用了系统的线，则高度要加一
        return  height + 1;
    }
    
}
@end

@implementation  UITableView(NMCustomTableView)

- (UITableViewCell *)nm_customCellWithCellName:(NSString *)cellName {
   
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

- (YYMemoryCache *)cellHeightCache {

    YYMemoryCache * dic = objc_getAssociatedObject(self, @selector(cellHeightCache));
    if (dic== nil) {
        dic = [[YYMemoryCache alloc]init];
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