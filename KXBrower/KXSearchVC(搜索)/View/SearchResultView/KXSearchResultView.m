//
//  KXSearchResultView.m
//  KXBrower
//
//  Created by apple on 17/3/27.
//  Copyright © 2017年 KXX. All rights reserved.
//

#import "KXSearchResultView.h"
#import "KXSearchResultDataCell.h"              //数据cell
#import "KXSearchResultDataHeaderView.h"        //headerView

#import "KXSearchResultFooterCell.h"           //底部提示其他团购 cell

//#import "BusinessDetailsViewController.h"      //商家详情页面
//#import "ProductDetailsViewController.h"       //订单详情页面

@interface KXSearchResultView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray *sectionArray;
@property (nonatomic,strong) NSMutableArray *flagArray;


@property (nonatomic, assign) NSInteger page;       //页数
@property (nonatomic, assign) NSInteger pageCount;  //总页数
@end

@implementation KXSearchResultView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        
        
        //2.初始化 tableView
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KXScreenW, KXScreenH - KXNavBarH) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        [self addSubview:_tableView];
        
        
        //1.数据
        self.page = 0;
        _sectionArray = [NSMutableArray array];
        [self setupRefresh];
    }
    return self;
}
#pragma mark - 1.数据
#pragma mark 开始进入刷新状态

- (void)setupRefresh
{
     _flagArray  = [NSMutableArray array];
    for (int i = 0; i < 10; i ++) {

       [_flagArray addObject:@"0"];
        NSDictionary * dic = @{
                               @"area" : @"111",
                               @"category" :@"222",
                               @"distance" : @"745.851km",
            @"is_has_quan" : @"1",
            @"is_has_tuan" : @"1",
            @"is_has_zhe" : @"1",
            @"mer_id" : @"13",
            @"mer_pic" : @"statics",
            @"merchant_name" : @"nin",
            @"quan_text" : @"sdf",
            @"star_count" : @"564",
            @"tuan_list" :            @ [
                                       @{
                                           @"id" : @"350",
                                           @"mendian_price" : @"148.00",
                                           @"sold" : @"0",
                                           @"title" : @"sdsdf",
                                           @"tuan_price" : @"118.00"
                                       },
                                       @{
                                         @"id" : @"350",
                                         @"mendian_price" : @"148.00",
                                         @"sold" : @"0",
                                         @"title" : @"sdsdf",
                                         @"tuan_price" : @"118.00"
                                       },
                                       @{
                                         @"id" : @"350",
                                         @"mendian_price" : @"148.00",
                                         @"sold" : @"0",
                                         @"title" : @"sdsdf",
                                         @"tuan_price" : @"118.00"                                       }
                                        ],
            @"tuan_text" : @"sdf"
             };
        
            [_sectionArray addObject:dic];
    }
    
}



#pragma mark - 2. UITableViewDataSource,UITableViewDelegate
//设置组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (_sectionArray.count == 0) {
        [self setupTableView:self.tableView backgroundImg:@""];
    }else{
        self.tableView.separatorStyle =UITableViewCellSeparatorStyleSingleLine;
        self.tableView.backgroundView.hidden = YES;
    }
    return _sectionArray.count;
}


//设置空白 数据页面  背景图
- (void)setupTableView:(UITableView *)tableView backgroundImg:(NSString *)imgstr
{
    UIImageView * backImage = [[UIImageView alloc] init];
    UIImageView * subImage = [[UIImageView alloc] init];
    //            subImage.image = [UIImage imageNamed:@"tableView_blank_comment"];
    subImage.image = [UIImage imageNamed:imgstr];
    CGFloat subW = subImage.image.size.width/3.0;
    CGFloat subH = subImage.image.size.height/3.0;
    CGFloat subX = (tableView.frame.size.width - subW)/2;
    CGFloat subY = (tableView.frame.size.height - subH)/2;
    subImage.frame = CGRectMake(subX, subY, subW,subH);
    [backImage addSubview:subImage];
    [self addSubview:backImage];
    tableView.backgroundView = backImage;
    //    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = _sectionArray[section][@"tuan_list"];
    if ([_flagArray[section] isEqualToString:@"0"]) {
        if (arr.count > 2) {
            return 3;
        }else{
            return arr.count;
        }
        
    }else{
        return arr.count;
    }
}
//组头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 110;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == _sectionArray.count-1) {
        return 0.5;
    }else{
        return 15;
    }
    
}
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *arr = _sectionArray[indexPath.section];
    if ([_flagArray[indexPath.section] isEqualToString:@"0"]) {
        if (arr.count > 2 && indexPath.row == 2) {
            return 40;
        }else{
            return 60;
        }
        
    }else{
        
        return 60;
    }
    
}
//  组头
// 定义头标题的视图，添加点击事件
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //    MyData *data = [dataArray objectAtIndex:section];
    
    KXSearchResultDataHeaderView * btn = [KXSearchResultDataHeaderView buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, KXScreenW, 110);
    btn.dic = _sectionArray[section];
    btn.tag = section;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}
- (void)btnClick:(UIButton *)btn
{
//    //跳转 商家详情页面
//    BusinessDetailsViewController * businessDVC = [[BusinessDetailsViewController alloc] init];
//    businessDVC.merID = [NSString stringWithFormat:@"%@",[_sectionArray[btn.tag] objectForKey:@"mer_id"]];
//    
//    [[self currentViewController].navigationController pushViewController:businessDVC animated:YES];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *arr = _sectionArray[indexPath.section][@"tuan_list"];
    if ([_flagArray[indexPath.section] isEqualToString:@"0"] && arr.count > 2){
        
        if (indexPath.row == 2) {
            KXSearchResultFooterCell * cell = [KXSearchResultFooterCell searchResultFooterCellWithTableView:tableView];
            int otherCount = (int)arr.count - 2;
            cell.otherLab.text = [NSString stringWithFormat:@"查看其他%d个团购",otherCount];
            cell.clipsToBounds = YES;//这句话很重要 不信你就试试</strong></span>
            return cell;
        }else{
            KXSearchResultDataCell * cell = [KXSearchResultDataCell searchResultDataCellWithTableView:tableView];
            cell.dic = arr[indexPath.row];
            cell.clipsToBounds = YES;
            return cell;
        }
        
    }else{
        
        KXSearchResultDataCell * cell = [KXSearchResultDataCell searchResultDataCellWithTableView:tableView];
        cell.dic = arr[indexPath.row];
        cell.clipsToBounds = YES;
        return cell;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSIndexPath * selectedIndex = [self.tableView indexPathForSelectedRow];
    UITableViewCell * cell = [self.tableView cellForRowAtIndexPath:selectedIndex];
    
    if ([cell isKindOfClass:[KXSearchResultFooterCell class]]) {
        //1.获取当前section的 用来加载section下面的cell的数组
        NSMutableArray *indexArray = [[NSMutableArray alloc]init];
        NSArray *arr = _sectionArray[selectedIndex.section];
        for (int i = 0; i < arr.count; i ++) {
            NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:selectedIndex.section];
            [indexArray addObject:path];
            
        }
        
        //    展开
        if ([_flagArray[selectedIndex.section] isEqualToString:@"0"]) {
            _flagArray[selectedIndex.section] = @"1";
            
            //刷整个section
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:selectedIndex.section];
            [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            
        }
        
    }else{
        // 跳转具体的商品页面
        NSArray *arr = _sectionArray[indexPath.section][@"tuan_list"];
        NSString * ID = [arr[indexPath.row] objectForKey:@"id"];
//        ProductDetailsViewController * productDVC = [[ProductDetailsViewController alloc] init];
//        productDVC.ID = ID;
//        productDVC.merID =  [NSString stringWithFormat:@"%@",[_sectionArray[selectedIndex.section] objectForKey:@"mer_id"]];
//        
//        [[self currentViewController].navigationController pushViewController:productDVC animated:YES];
        
    }
}




#pragma mark - 3.其他
#pragma mark -- 3.0  UIScrollViewDelegate -滑动的时候 隐藏键盘
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSArray *wsArray = [[UIApplication sharedApplication] windows];
    for(UIView *aView in wsArray){
        [self resignKeyBoardInView:aView];
    }
}

- (void)resignKeyBoardInView:(UIView *)view
{
    for (UIView *aView in view.subviews) {
        if ([aView.subviews count] > 0) {
            [self resignKeyBoardInView:aView];
        }
        //当只有UITextView，UITextField情况会影响键盘时，加条件判断
        //如果是系统短信界面的键盘则不要判断条件，直接执行 [aView resignFirstResponder];
        if ([aView isKindOfClass:[UITextView class]] || [aView isKindOfClass:[UITextField class]] ) {
            [aView resignFirstResponder];
        }
    }
}
//3.1 
- (void)dismissHud
{
//    [SVProgressHUD dismiss];
}

- (UIViewController *)currentViewController
{
    //获取当前view的superView对应的控制器
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
    
}


@end
