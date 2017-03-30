//
//  KXHotSearchHeaderView.h
//  KXBrower
//
//  Created by apple on 17/3/24.
//  Copyright © 2017年 KXX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KXHotSearchHeaderView;
@protocol KXHotSearchHeaderViewDelegate <NSObject>
@optional
/** 点击 热门搜索 的cell 事件*/
- (void)hotSearchHeaderViewCollectionCellClick:(NSString *)collectionCellText;
@end

@interface KXHotSearchHeaderView : UIView
@property (nonatomic, weak) id<KXHotSearchHeaderViewDelegate> delegate;

@end
