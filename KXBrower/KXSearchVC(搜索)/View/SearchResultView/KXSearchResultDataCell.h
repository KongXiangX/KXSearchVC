//
//  KXSearchResultDataCell.h
//  KXBrower
//
//  Created by apple on 17/3/27.
//  Copyright © 2017年 KXX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KXSearchResultDataCell : UITableViewCell
@property (nonatomic, strong) NSDictionary * dic;

+ (instancetype)searchResultDataCellWithTableView:(UITableView *)tableView;
@end
