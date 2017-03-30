//
//  KXSearchResultCell.h
//  KXBrower
//
//  Created by apple on 17/3/27.
//  Copyright © 2017年 KXX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KXSearchResultCell : UITableViewCell
@property (nonatomic, strong) UILabel * leftLab;        //左边的lab
@property (nonatomic, strong) UIImageView * searchImg;  //放大镜图片
@property (nonatomic, strong) UIImageView * arrowImg;   //箭头

+ (instancetype)searchResultCellWithTableView:(UITableView *)tableView;
@end
