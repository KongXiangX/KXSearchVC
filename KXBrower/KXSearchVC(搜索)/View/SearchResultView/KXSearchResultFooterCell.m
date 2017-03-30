//
//  KXSearchResultFooterCell.m
//  KXBrower
//
//  Created by apple on 17/3/27.
//  Copyright © 2017年 KXX. All rights reserved.
//

#import "KXSearchResultFooterCell.h"

@interface KXSearchResultFooterCell ()

@property (nonatomic, strong) UIImageView * downImg;     //向下的img

@property (nonatomic, strong) UIImageView * barImg;      //灰线
@end

@implementation KXSearchResultFooterCell

#pragma mark - 快速创建Cell
+ (instancetype)searchResultFooterCellWithTableView:(UITableView *)tableView
{
    static NSString * KXSearchResultFooterCellID = @"KXSearchResultFooterCellID";
    KXSearchResultFooterCell *cell = [tableView dequeueReusableCellWithIdentifier:KXSearchResultFooterCellID];
    if (cell == nil) {
        cell = [[KXSearchResultFooterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:KXSearchResultFooterCellID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
        
        //1.价格
        UILabel * otherLab = [[UILabel alloc] init];
        otherLab.font = [UIFont boldSystemFontOfSize:18];
        otherLab.textColor = KXColor(24, 143, 244);
        //        otherLab.text = @"查看其他团购";
        otherLab.adjustsFontSizeToFitWidth = YES;
        //        priceLab.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        otherLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:otherLab];
        self.otherLab = otherLab;
        
        //2.向下的img
        UIImageView * downImg = [[UIImageView alloc] init];
        downImg.image = [UIImage imageNamed:@"向下箭头"];
        [self.contentView addSubview:downImg];
        self.downImg = downImg;
        //
        //        //3.分割线
        //        UIImageView * barImg = [[UIImageView alloc] init];
        //        barImg.backgroundColor = KXColor(157, 157, 157);
        //        [self.contentView addSubview:barImg];
        //        self.barImg = barImg;
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat viewH = self.bounds.size.height;
    //    CGFloat margin = 10;
    //
    //    CGFloat priceLabW = 120;
    //1.价格
    self.otherLab.frame = CGRectMake(0, 0, KXScreenW, viewH);
    //    self.priceLab.backgroundColor = [UIColor redColor];
    
    //2.向下的img
    self.downImg.frame = CGRectMake(KXScreenW/2 + 80, (viewH - 12)/2, 20, 12);
    
    //3.分割线
    //    self.barImg.frame = CGRectMake(10, viewH - 1.0, KXScreenW, 1.0);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
}

@end
