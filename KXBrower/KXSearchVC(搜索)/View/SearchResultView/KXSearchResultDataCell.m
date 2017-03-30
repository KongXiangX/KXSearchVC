//
//  KXSearchResultDataCell.m
//  KXBrower
//
//  Created by apple on 17/3/27.
//  Copyright © 2017年 KXX. All rights reserved.
//

#import "KXSearchResultDataCell.h"
@interface KXSearchResultDataCell ()
@property (nonatomic, strong) UILabel * priceLab;      //价格
@property (nonatomic, strong) UILabel * usrMsgLab;     //使用规则
@property (nonatomic, strong) UILabel * rateLab;       //门市价
@property (nonatomic, strong) UILabel * soldLab;       //已售

@property (nonatomic, strong) UIImageView * barImg;     //灰线

@end

@implementation KXSearchResultDataCell
#pragma mark - 快速创建Cell
+ (instancetype)searchResultDataCellWithTableView:(UITableView *)tableView
{
    static NSString * KXSearchResultDataCellID = @"KXSearchResultDataCellID";
    KXSearchResultDataCell *cell = [tableView dequeueReusableCellWithIdentifier:KXSearchResultDataCellID];
    if (cell == nil) {
        cell = [[KXSearchResultDataCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:KXSearchResultDataCellID];
    }
    return cell;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        //1.价格
        UILabel * priceLab = [[UILabel alloc] init];
        priceLab.font = [UIFont boldSystemFontOfSize:18];
        priceLab.textColor = KXColor(24, 143, 244);
        //        priceLab.text = @"¥1225";
        priceLab.adjustsFontSizeToFitWidth = YES;
        //        priceLab.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        priceLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:priceLab];
        self.priceLab = priceLab;
        
        //2.使用规则
        UILabel * usrMsgLab = [[UILabel alloc] init];
        usrMsgLab.font = [UIFont boldSystemFontOfSize:16];
        usrMsgLab.textColor = [UIColor grayColor];
        //        usrMsgLab.text = @"使用";
        //        usrMsgLab.adjustsFontSizeToFitWidth = YES;
        //        usrMsgLab.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        usrMsgLab.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:usrMsgLab];
        self.usrMsgLab = usrMsgLab;
        
        //3.门市价
        UILabel * rateLab = [[UILabel alloc] init];
        rateLab.font = [UIFont systemFontOfSize:15];
        rateLab.textColor = KXColor(157, 157, 157);
        //        rateLab.text = @"门市价";
        rateLab.adjustsFontSizeToFitWidth = YES;
        //        rateLab.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        rateLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:rateLab];
        self.rateLab = rateLab;
        
        //4.已售
        UILabel * soldLab = [[UILabel alloc] init];
        soldLab.font = [UIFont systemFontOfSize:15];
        soldLab.adjustsFontSizeToFitWidth = YES;
        soldLab.textColor = KXColor(157, 157, 157);
        //        soldLab.text = @"已售2130";
        //        soldLab.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        soldLab.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:soldLab];
        self.soldLab = soldLab;
        
        //5.分割线
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
    CGFloat labH = 30;
    CGFloat priceLabW = 120;
    //1.价格
    self.priceLab.frame = CGRectMake(0, 0, priceLabW, labH);
    //    self.priceLab.backgroundColor = [UIColor redColor];
    
    //2.使用规则
    self.usrMsgLab.frame = CGRectMake(priceLabW + margin, 0, KXScreenW - priceLabW -2*margin, labH);
    //    self.usrMsgLab.backgroundColor = [UIColor orangeColor];
    
    //3.门市价
    self.rateLab.frame = CGRectMake(0 , labH, priceLabW, labH);
    //    self.rateLab.backgroundColor = [UIColor orangeColor];
    
    //4.已售
    self.soldLab.frame = CGRectMake(priceLabW + margin, labH, KXScreenW - priceLabW -2*margin, labH);
    //    self.soldLab.backgroundColor = [UIColor redColor];
    
    //5.分割线
    self.barImg.frame = CGRectMake(10, viewH - 1.0, KXScreenW, 1.0);
}

-(void)setDic:(NSDictionary *)dic
{
    _dic = dic;
    
    //1.价格
    self.priceLab.text = [NSString stringWithFormat:@"¥%@",dic[@"tuan_price"]];
    
    //2.使用规则
    self.usrMsgLab.text = [NSString stringWithFormat:@"%@",dic[@"title"]];
    
    //3.门市价
    self.rateLab.text = [NSString stringWithFormat:@"门市价:¥%@",dic[@"mendian_price"]];
    //4.已售
    self.soldLab.text = [NSString stringWithFormat:@"已售%@",dic[@"sold"]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
}

@end
