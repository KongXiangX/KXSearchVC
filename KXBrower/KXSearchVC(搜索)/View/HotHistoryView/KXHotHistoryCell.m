//
//  KXHotHistoryCell.m
//  KXBrower
//
//  Created by apple on 17/3/24.
//  Copyright © 2017年 KXX. All rights reserved.
//

#import "KXHotHistoryCell.h"



@interface KXHotHistoryCell ()
@property (nonatomic, strong) UIImageView * barImg;     //灰线

@end

@implementation KXHotHistoryCell

#pragma mark - 快速创建Cell
+ (instancetype)hotHistoryCellWithTableView:(UITableView *)tableView
{
    static NSString * KXHotHistoryCellID = @"KXHotHistoryCellID";
    KXHotHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:KXHotHistoryCellID];
    if (cell == nil) {
        cell = [[KXHotHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:KXHotHistoryCellID];
    }
    return cell;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //0.放大镜图片
        UIImageView * searchImg = [[UIImageView alloc] init];
        searchImg.image = [UIImage imageNamed:@"HotHistoryCell_magnifier"];
        [self.contentView addSubview:searchImg];
        self.searchImg = searchImg;
        
        //1. 左边lab
        UILabel * leftLab = [[UILabel alloc] init];
        leftLab.font = [UIFont systemFontOfSize:15];
        //        leftLab.adjustsFontSizeToFitWidth = YES;
        leftLab.textColor = [UIColor blackColor];
        leftLab.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        leftLab.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:leftLab];
        self.leftLab = leftLab;
        
        
        //2.箭头
        UIImageView * arrowImg = [[UIImageView alloc] init];
        arrowImg.image = [UIImage imageNamed:@"进入图标"];
        [self.contentView addSubview:arrowImg];
        self.arrowImg = arrowImg;
        
        //3.灰线
        UIImageView * barImg = [[UIImageView alloc] init];
        barImg.backgroundColor = KXColor(230, 230, 230);
        [self.contentView addSubview:barImg];
        self.barImg = barImg;
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat viewH = self.bounds.size.height;
    CGFloat margin = 10;
    
    /** 箭头高 */
    CGFloat  ArrowH   =25;
    /** 箭头宽 */
    CGFloat  ArrowW   = 13;
    
    //0.放大镜图片
    self.searchImg.frame = CGRectMake(margin, 10, 20, 20);
    
    //1.  左边lab
    self.leftLab.frame = CGRectMake(50, 0 ,KXScreenW - 100, 40);
    
    
    
    CGFloat arrowY = (viewH - ArrowH )/2;
    //3.箭头
    self.arrowImg.frame = CGRectMake(KXScreenW - ArrowW - margin, arrowY,ArrowW, ArrowH);
    
    
    //4. 灰线
    self.barImg.frame = CGRectMake(10, viewH - 1.0, KXScreenW, 1.0);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
}


@end
