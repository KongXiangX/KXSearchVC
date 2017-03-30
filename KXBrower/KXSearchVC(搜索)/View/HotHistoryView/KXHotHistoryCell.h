//
//  KXHotHistoryCell.h
//  KXBrower
//
//  Created by apple on 17/3/24.
//  Copyright © 2017年 KXX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KXHotHistoryCell : UITableViewCell
@property (nonatomic, strong) UILabel * leftLab;        //左边的lab
@property (nonatomic, strong) UIImageView * searchImg;  //放大镜图片
@property (nonatomic, strong) UIImageView * arrowImg;   //箭头

+ (instancetype)hotHistoryCellWithTableView:(UITableView *)tableView;
@end
