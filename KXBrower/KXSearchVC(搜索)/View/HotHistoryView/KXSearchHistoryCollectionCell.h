//
//  KXSearchHistoryCollectionCell.h
//  KXBrower
//
//  Created by apple on 17/3/24.
//  Copyright © 2017年 KXX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KXSearchHistoryCollectionCell;
@protocol KXSearchHistoryCollectionCellDelegate <NSObject>
@optional
- (void)deleteFreeCollectionCell:(KXSearchHistoryCollectionCell *)cell;

@end

@interface KXSearchHistoryCollectionCell : UICollectionViewCell
@property (nonatomic, weak  ) id <KXSearchHistoryCollectionCellDelegate> delegate;
@property (nonatomic, strong) UILabel * lab;    //lab
@end
