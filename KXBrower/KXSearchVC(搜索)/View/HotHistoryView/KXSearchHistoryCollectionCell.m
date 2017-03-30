//
//  KXSearchHistoryCollectionCell.m
//  KXBrower
//
//  Created by apple on 17/3/24.
//  Copyright © 2017年 KXX. All rights reserved.
//

#import "KXSearchHistoryCollectionCell.h"

@implementation KXSearchHistoryCollectionCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //1.lab
        UILabel * lab = [[UILabel alloc] init];
        lab.backgroundColor = [UIColor whiteColor];
        lab.font = [UIFont systemFontOfSize:15];
        lab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:lab];
        self.lab = lab;
        
        
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //1. lab
    self.lab.frame = CGRectMake(0, 0, self.frame.size.width, 40);
    
    
}
-(void)delBtnClick
{
    if ([self.delegate respondsToSelector:@selector(deleteFreeCollectionCell:)]) {
        [self.delegate deleteFreeCollectionCell:self];
    }
}

@end
