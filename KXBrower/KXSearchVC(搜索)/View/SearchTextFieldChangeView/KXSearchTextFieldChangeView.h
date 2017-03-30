//
//  KXSearchTextFieldChangeView.h
//  KXBrower
//
//  Created by apple on 17/3/29.
//  Copyright © 2017年 KXX. All rights reserved.
//

#import <UIKit/UIKit.h>


@class KXHotHistoryView;
@protocol KXSearchTextFieldChangeViewDelegate <NSObject>
@optional
/** 监听 textFieldChangeView 里面的点击 事件*/
- (void)tapChangViewCellWithStr:(NSString *)str;

@end

@interface KXSearchTextFieldChangeView : UIView
@property (nonatomic, weak) id<KXSearchTextFieldChangeViewDelegate>delegate;
@property (nonatomic, copy) NSString * currentEdtingStr; //当前字符串
@end
