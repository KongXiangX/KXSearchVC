//
//  KXSearchResultDataHeaderView.m
//  KXBrower
//
//  Created by apple on 17/3/27.
//  Copyright © 2017年 KXX. All rights reserved.
//

#import "KXSearchResultDataHeaderView.h"

//#import "CWStarRateView.h"  //星级
//#import "UIImageView+WebCache.h"

@interface KXSearchResultDataHeaderView ()
@property (nonatomic, strong) UIImageView * goodPic;     //商品图片
@property (nonatomic, strong) UILabel * storeNameLab;    //商店名
@property (nonatomic, strong) UILabel * goodNameLab;     //商品名
@property (nonatomic, strong) UILabel * distanceLab;     //距离
//@property (nonatomic, strong) CWStarRateView *starView;  //星级
@property (nonatomic, strong) UILabel * starLab;         //星级分数lab

@property (nonatomic, strong) UIImageView * barImg;     //灰线
@end

@implementation KXSearchResultDataHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        CGFloat margin = 10;
        CGFloat labH = 30;
        self.backgroundColor = [UIColor whiteColor];
        
        
        CGFloat goodPicW = 90;
        //1.商品图片
        self.goodPic = [[UIImageView alloc] init];
        self.goodPic.frame = CGRectMake(margin, margin, goodPicW, goodPicW);
        self.goodPic.image = [UIImage imageNamed:@"isGetCard"];
        [self addSubview:self.goodPic];
        
        CGFloat storeNameLabX = goodPicW + margin*2;
        //2.商店名
        self.storeNameLab = [[UILabel alloc] initWithFrame:CGRectMake(storeNameLabX, margin, KXScreenW - storeNameLabX -margin, labH)];
        self.storeNameLab.font = [UIFont boldSystemFontOfSize:17];
        self.storeNameLab.textColor = [UIColor blackColor];
        self.storeNameLab.text = @"长青小麦";
        self.storeNameLab.adjustsFontSizeToFitWidth = YES;
        self.storeNameLab.textAlignment = NSTextAlignmentLeft;
        [self addSubview: self.storeNameLab];
        
        
        CGFloat starViewW = 120;
        //3.星级 以及分数
//        self.starView = [[CWStarRateView alloc] initWithFrame:CGRectMake(storeNameLabX, margin + labH, starViewW, labH)];
//        self.starView.scorePercent = 0.2;
//        self.starView.allowIncompleteStar = YES;
//        self.starView.hasAnimation = YES;
//        self.starView.userInteractionEnabled = NO;
//        //        self.starView.scorePercent = 5;
//        [self addSubview:self.starView];
        
        
        self.starLab = [[UILabel alloc] initWithFrame:CGRectMake(storeNameLabX + starViewW + margin, margin + labH, KXScreenW - storeNameLabX -margin, labH)];
        self.starLab.font = [UIFont boldSystemFontOfSize:18];
        self.starLab.textColor = KXColor(255, 198, 0);
        self.starLab.adjustsFontSizeToFitWidth = YES;
        self.starLab.textAlignment = NSTextAlignmentLeft;
        [self addSubview: self.starLab];
        
        
        
        CGFloat goodNameLabW = 100;
        //4.商品名
        self.goodNameLab = [[UILabel alloc] initWithFrame:CGRectMake(storeNameLabX, margin + labH*2, goodNameLabW, labH)];
        self.goodNameLab.font = [UIFont systemFontOfSize:15];
        self.goodNameLab.textColor = [UIColor blackColor];
        //        self.goodNameLab.text = @"小麦";
        self.goodNameLab.adjustsFontSizeToFitWidth = YES;
        self.goodNameLab.textAlignment = NSTextAlignmentLeft;
        [self addSubview: self.goodNameLab];
        
        //5.距离
        self.distanceLab = [[UILabel alloc] initWithFrame:CGRectMake(storeNameLabX + goodNameLabW, margin + labH*2, KXScreenW - storeNameLabX -margin - goodNameLabW, labH)];
        self.distanceLab.font = [UIFont systemFontOfSize:15];
        self.distanceLab.textColor = [UIColor blackColor];
        //        self.distanceLab.text = @"距离";
        self.distanceLab.adjustsFontSizeToFitWidth = YES;
        self.distanceLab.textAlignment = NSTextAlignmentLeft;
        [self addSubview: self.distanceLab];
        
        //6.灰线
        UIImageView * barImg = [[UIImageView alloc] init];
        barImg.frame = CGRectMake(0, 110 - 1, KXScreenW, 1);
        barImg.backgroundColor = KXColor(230, 230, 230);
        [self addSubview:barImg];
        
    }
    return self;
}
- (void)setDic:(NSDictionary *)dic
{
    _dic = dic;
    //1.商品图片
//    NSString * imgStr = [NSString stringWithFormat:@"%@%@",ImageNetConnector,dic[@"mer_pic"]];
//    NSURL * imgUrl = [NSURL URLWithString:imgStr];
    
    
//    [self.goodPic sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"默认.png"]];
    
//    //2.商店名
//    self.storeNameLab.text = [NSString stringWithFormat:@"%@",dic[@"merchant_name"]];
//    
//    //3.商品名
//    self.goodNameLab.text = [NSString stringWithFormat:@"%@",dic[@"category"]];
//    
//    //4.距离
//    self.distanceLab.text = [NSString stringWithFormat:@"%@",dic[@"distance"]];
//    
//    //5.星级
//    self.starLab.text = [NSString stringWithFormat:@"%@分",dic[@"star_count"]];
//    CGFloat scroeNum = [[NSString stringWithFormat:@"%@",dic[@"star_count"]] floatValue];
    
//    self.starView.scorePercent = scroeNum/5.0;
    
}


@end
