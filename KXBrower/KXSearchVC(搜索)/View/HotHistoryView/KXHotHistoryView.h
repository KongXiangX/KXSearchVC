//
//  KXHotHistoryView.h
//  KXBrower
//
//  Created by apple on 17/3/24.
//  Copyright © 2017年 KXX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KXHotHistoryView;
@protocol KXHotHistoryViewDelegate <NSObject>
@optional
/** 监听有关 热门搜索 与  历史搜索 页面 按钮  点击事件 */
- (void)tapCurrentCellWithStr:(NSString *)str;

@end

@interface KXHotHistoryView : UIView
@property (nonatomic, weak) id<KXHotHistoryViewDelegate> delegate; 
@property (nonatomic, copy) NSString * sourceVC;   //来自哪个搜索界面（one:第一个  two:第二个）
@end
