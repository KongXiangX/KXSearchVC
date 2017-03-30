//
//  KXHotHistoryView.m
//  KXBrower
//
//  Created by apple on 17/3/24.
//  Copyright © 2017年 KXX. All rights reserved.
//

#import "KXHotHistoryView.h"
#import "KXHotHistoryCell.h"        //cell
#import "KXHotSearchHeaderView.h"   //热门搜索 Header
#import "KXSearchResultVC.h"        //搜索结果界面


@interface KXHotHistoryView ()<UITableViewDelegate,UITableViewDataSource,KXHotSearchHeaderViewDelegate>
@property (nonatomic, strong) UITableView * historyTable;

//tableView的历史搜索的数据
@property (nonatomic, strong) NSMutableArray * tablViewArr;

//section 1里面的headerView的lab
@property (nonatomic, strong) UILabel * historyLab;



@end

@implementation KXHotHistoryView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        
        //0.获取  本地存储的  搜索记录数据
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        NSArray * myArray = [userDefaultes arrayForKey:KXHistoryRecordArr];
        self.tablViewArr = [NSMutableArray array];
        [self.tablViewArr addObjectsFromArray:myArray];
        
        //1.初始化tableView
        UITableView * historyTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KXScreenW, KXScreenH ) style:UITableViewStylePlain];
        historyTable.delegate = self;
        historyTable.dataSource = self;
        historyTable.showsVerticalScrollIndicator = NO;
        historyTable.backgroundColor = KXColor(245, 245, 245);
        historyTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:historyTable];
        self.historyTable = historyTable;
        
  
        //2.headerView
        [self setupTableViewHeaderView];

    }
    return self;
}


#pragma mark - 1.0  UITableViewDataSource
//section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
//headerView 的间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else{
        return 40;
    }
    
}

//设置 不同的 section 中的 HeaderView
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return [self setupTableViewHeaderView];
        
    }else{
      
        UILabel * headerLabel = [[UILabel alloc] init];
        if (self.tablViewArr.count == 0) {
            
        }else{
            headerLabel.backgroundColor = KXColor(245, 245, 245);
            headerLabel.textColor = KXColor(183, 183, 183);
            headerLabel.font = [UIFont boldSystemFontOfSize:16];
            headerLabel.text = @"  历史搜索";
            headerLabel.textAlignment = NSTextAlignmentLeft;
            
        }
        return headerLabel;
    }
    
}

//不同 section 中cell 的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (section == 0) {
        return 0;
    }else{
        if (self.tablViewArr.count <= 0) {
            return 0;
        }else{
            return self.tablViewArr.count + 1;
        }
        
    }
    
}
//不同 section 中cell 的高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 0;
    }else{
        return 40;
    }
    
}
//不同 section 中cell 的初始化 方法
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    KXHotHistoryCell * cell = [KXHotHistoryCell hotHistoryCellWithTableView:tableView];
    NSInteger lastRow = (NSInteger)self.tablViewArr.count;
    
    if (self.tablViewArr.count <= 0) {
        [self hiddenCellImgView:cell];
    }else{
        if (indexPath.row  == lastRow ) {
            [self hiddenCellImgView:cell];
        }else{
            cell.leftLab.text = self.tablViewArr[indexPath.row];
            //            cell.leftLab.textColor = QYColor(183, 183, 183);
        }
    }
    
    
    return cell;
}
#pragma mark -- 隐藏cell 里面图片
- (void)hiddenCellImgView:(KXHotHistoryCell *)cell
{
    cell.arrowImg.hidden = YES;
    cell.searchImg.hidden = YES;
    cell.leftLab.text = @"清除搜索记录";
    cell.leftLab.textAlignment = NSTextAlignmentCenter;
    
    
}

#pragma mark -- 1.2  UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSIndexPath * selectIndex = [tableView indexPathForSelectedRow];
    KXHotHistoryCell *cell = (KXHotHistoryCell *)[tableView cellForRowAtIndexPath:selectIndex];
    
    //1.清除缓存
    if ([cell.leftLab.text isEqualToString:@"清除搜索记录"]) {
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        NSArray * myArray = [userDefaultes arrayForKey:KXHistoryRecordArr];
        NSMutableArray *searTXT = [myArray mutableCopy];
        [searTXT removeAllObjects];
        self.tablViewArr = searTXT;
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:searTXT forKey:KXHistoryRecordArr];
        
        [userDefaults synchronize];
        [tableView reloadData];
        
    }else{
        //1.代理
        if ([self.delegate respondsToSelector:@selector(tapCurrentCellWithStr:)]) {
            [self.delegate tapCurrentCellWithStr:cell.leftLab.text];
        }
        //2.添加数据
        //        NSString * currentCellStr = cell.leftLab.text;
        [self currentStr:cell.leftLab.text];
        //3.网络请求
        [self setupData];

        //4.记录 搜索文字
        [self recordCurrentTextFieldStr:cell.leftLab.text];
        
        
    }
    
}



#pragma mark - 2. setupTableViewHeaderView 顶部view
- (UIView *)setupTableViewHeaderView
{
    //0.bg
    KXHotSearchHeaderView * headerView = [[KXHotSearchHeaderView alloc] init];
    headerView.delegate = self;
    headerView.frame = CGRectMake(0, 0, KXScreenW, 160);
    self.historyTable.tableHeaderView = headerView;
    return headerView;
}


#pragma mark -- 2.1 KXHotSearchHeaderViewDelegate
- (void)hotSearchHeaderViewCollectionCellClick:(NSString *)collectionCellText
{
    NSLog(@"点击了热门搜索:%@",collectionCellText);

    if ([self.delegate respondsToSelector:@selector(tapCurrentCellWithStr:)]) {
        [self.delegate tapCurrentCellWithStr:collectionCellText];
    }
    //1.网络请求
    [self setupData];

    //2.记录 搜索文字
    [self recordCurrentTextFieldStr:collectionCellText];
}
#pragma mark -- 请求数据
- (void)setupData
{
    
    //2.如果是第二个页面只是刷新数据
    if ([self.sourceVC isEqualToString:@"one"]) {
        //模仿 美团 跳转成一个 新的 搜索界面
        [[self currentViewController] popoverPresentationController];
        [self backAndPostNotifation];
//        KXSearchResultVC *resultVC = [[KXSearchResultVC alloc] init];
//        resultVC.view.backgroundColor = [UIColor whiteColor];
//        [[self currentViewController].navigationController pushViewController:resultVC animated:YES];
        

    }else{
        
    }
    
    
//    _keywords = _searchTF.text;
//    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
//    NSString * city;
//    if ([_city containsString:@"市"]){
//        city = [_city substringToIndex:_city.length-1];
//    }else{
//        city = _city;
//    }
//    //    NSDictionary * dic = @{@"keywords" : _keywords,
//    //                           @"city" : city,
//    //                           };
//    
//    NSDictionary * dic = @{@"keywords" : _keywords,
//                           @"city" : city,
//                           @"latitude" : [[userDefaults objectForKey:@"userlocation"] objectForKey:@"latitude"],
//                           @"longitude" : [[userDefaults objectForKey:@"userlocation"] objectForKey:@"longitude"]};
//    [self netWorkForSearch:dic];
//    
//    NSString * url = [NSString stringWithFormat:@"%@m=Index&a=get_Favors_from_search",NetConnector];
//    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
//    [manager POST:url parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
//        
//        [_searchTF resignFirstResponder];
//        
//        NSDictionary * dic = (NSDictionary *) responseObject;
//        NSString * backMsg = [NSString stringWithFormat:@"%@",dic[@"message"]];
//        if ([[dic objectForKey:@"err_code"] intValue] == 100) {
//            
//            
//            NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
//            [userDefaults setObject:dic forKey:QYPopTwoVCBackDataDic];
//            [userDefaults synchronize];
//            //4.反会上级页面 并且发送通知
//            [self backAndPostNotifation];
//            
//        }else{
//            
//            [SVProgressHUD showErrorWithStatus:backMsg];
//            [self performSelector:@selector(dismissHud) withObject:nil afterDelay:1.5];
//            
//        }
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        //断网仍然 跳转到 新的 搜索界面
//        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
//        [userDefaults setObject:dic forKey:QYPopTwoVCBackDataDic];
//        [userDefaults synchronize];
//        //4.反会上级页面 并且发送通知
//        [self backAndPostNotifation];
//    }];
    
}

- (void)backAndPostNotifation
{
    //3.跳转VC
    [[self currentViewController].navigationController popViewControllerAnimated:YES];
    //获取通知中心单例对象
    [[NSNotificationCenter defaultCenter] postNotificationName:KXPopTwoNotification object:nil];
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




#pragma mark -- 3.1 数据处理
- (void)currentStr:(NSString *)currentCellStr
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    NSArray *myArray = [[NSArray alloc] initWithArray:[userDefaultes arrayForKey:KXHistoryRecordArr]];
    
    // NSArray --> NSMutableArray
    NSMutableArray *searTXT = [NSMutableArray array];
    searTXT = [myArray mutableCopy];
    
    BOOL isEqualTo1,isEqualTo2;
    isEqualTo1 = NO,isEqualTo2 = NO;
    
    if (searTXT.count > 0) {
        isEqualTo2 = YES;
        //判断搜索内容是否存在，存在的话放到数组最后一位，不存在的话添加。
        for (NSString * str in myArray) {
            if ([currentCellStr isEqualToString:str]) {
                //获取指定对象的索引
                NSUInteger index = [myArray indexOfObject:currentCellStr];
                [searTXT removeObjectAtIndex:index];
                [searTXT insertObject:currentCellStr atIndex:0];
                isEqualTo1 = YES;
                break;
            }
        }
    }
    
    
    if (!isEqualTo1 || !isEqualTo2) {
        [searTXT insertObject:currentCellStr atIndex:0];
    }
    
    if(searTXT.count > 10)
    {
        [searTXT removeObjectAtIndex:10];
    }
    
    
    //将上述数据全部存储到NSUserDefaults中
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:searTXT forKey:KXHistoryRecordArr];
    [userDefaults synchronize];
}
#pragma mark -- 3.3 记录当前的 textField 中的文字
- (void)recordCurrentTextFieldStr:(NSString *)currentStr
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:currentStr forKey:KXCurrentTextFieldStr];
    [userDefaults synchronize];
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
