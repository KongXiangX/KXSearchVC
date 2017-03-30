//
//  KXSearchResultFooterCell.h
//  KXBrower
//
//  Created by apple on 17/3/27.
//  Copyright © 2017年 KXX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KXSearchResultFooterCell : UITableViewCell
@property (nonatomic, strong) UILabel * otherLab;        //文字 其他团购
+ (instancetype)searchResultFooterCellWithTableView:(UITableView *)tableView;
@end
