//
//  KXSearchVC.m
//  KXBrower
//
//  Created by apple on 17/3/24.
//  Copyright © 2017年 KXX. All rights reserved.
//

#import "KXSearchVC.h"
#import "KXSearchResultVC.h"   //搜索结果 新界面
#import "KXHotHistoryView.h"   //热门搜索 与  搜索历史 页面


@interface KXSearchVC ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField * searchTF;               //导航栏上面的搜索条
@property (nonatomic, strong) KXHotHistoryView * hotHistoryView;    //热门搜索界面View
@end

@implementation KXSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor purpleColor];
    
    //1.导航栏
    [self setupNavgationView];
    
    //2.热门搜索 与 历史记录 View
    [self setupHotHistoryView];
    
    //3.搜索结果 View
    [self setupSearchResultView];
    
//    //4.textField 搜索反馈页面
//    [self setupTextChangeView];
    
    
}

#pragma mark - 1.导航栏
- (void)setupNavgationView
{
    //1.左侧按钮
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 20, 44, 44);
//    [leftBtn setImage:[UIImage imageNamed:@"返回图标"] forState:UIControlStateNormal];
    [leftBtn setTitle:@"11" forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.backgroundColor = [UIColor redColor];
    UIBarButtonItem * leftBar = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBar;
    
    
    CGFloat searchBGViewH = 30;
    //2.中间搜索条
    UIView * searchBGView = [[UIView alloc] initWithFrame:CGRectMake(50, 27, KXScreenW - 80, searchBGViewH)];
    searchBGView.layer.cornerRadius = 15;
    searchBGView.clipsToBounds = YES;
    searchBGView.backgroundColor = [UIColor orangeColor];
    self.navigationItem.titleView = searchBGView;
    

    //2.1 放大镜图片
    CGFloat imgW = 30;
//    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 7.5, 15, 15)];
//    imageView.image = [UIImage imageNamed:@"查找放大镜"];
//    [searchBGView addSubview:imageView];
    
    _searchTF = [[UITextField alloc] initWithFrame:CGRectMake(imgW + 10, 0, KXScreenW - 80 - imgW - 20 ,searchBGViewH)];
    _searchTF.backgroundColor = [UIColor whiteColor];
    _searchTF.placeholder = @"输入商品名称...";
    _searchTF.font = [UIFont systemFontOfSize:15];
    _searchTF.keyboardType = UIKeyboardTypeDefault;
    _searchTF.returnKeyType = UIReturnKeySearch;
    _searchTF.delegate = self;
    _searchTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [searchBGView addSubview:_searchTF];

}
- (void)leftBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -- UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //1.空字符串 不隐藏键盘
    NSString * nilStr= [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if ([nilStr isEqualToString:@""]) {
        return NO;
    }
    
    //2.隐藏键盘
    [textField resignFirstResponder];
    
    //3.存储到本地 搜索的相应的数据
    if (textField.text.length <= 0  || [nilStr isEqualToString:@""]) {
        //2.0 如果 空 默认 搜索 placeholder 文字
        [self currentStr:textField.placeholder];
    }else{
        //2.1 如果 非空 搜索textField 输入的文字
        [self currentStr:textField.text];
    }
    
    //4.网络请求
//    [self setupData];
    //模仿美团跳转新的 搜索界面
    KXSearchResultVC * resultVC = [[KXSearchResultVC alloc] init];
    resultVC.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:resultVC animated:YES];
    [self backAndPostNotifation];
    //5.记录 搜索文字
    [self recordCurrentTextFieldStr:textField.text];
    
    return YES;
}

- (void)backAndPostNotifation
{
    //3.跳转VC
    [self.navigationController popViewControllerAnimated:YES];
    //获取通知中心单例对象
    [[NSNotificationCenter defaultCenter] postNotificationName:KXPopTwoNotification object:nil];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"....");
    [self.view endEditing:YES];
    [self.hotHistoryView endEditing:YES];
}

#pragma mark --1.0 判定存储  输入 数据
- (void)currentStr:(NSString *)currentCellStr
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    
    //1.读取数组NSArray类型的数据
    NSArray * previousArr =[userDefaultes objectForKey:KXHistoryRecordArr];

    // NSArray ---> NSMutableArray
    NSMutableArray * searchMutableArr = [NSMutableArray array];
    [searchMutableArr addObjectsFromArray:previousArr];
    
    
    BOOL isEqualTo1,isEqualTo2;
    isEqualTo1 = NO,isEqualTo2 = NO;
    
    //2.有记录的数据
    if (searchMutableArr.count > 0) {
        isEqualTo2 = YES;
        //2.1 判断搜索内容是否存在，存在的话放到数组第一位，不存在的话添加。
        for (NSString * str in previousArr) {
            if ([currentCellStr isEqualToString:str]) {
                //获取指定对象的索引
                NSUInteger index = [previousArr indexOfObject:currentCellStr];
                [searchMutableArr removeObjectAtIndex:index];
                [searchMutableArr insertObject:currentCellStr atIndex:0];
                isEqualTo1 = YES;
                break;
            }
        }
    }
    
    //2.无记录 直接插入数据
    if (!isEqualTo1 || !isEqualTo2) {
        [searchMutableArr insertObject:currentCellStr atIndex:0];
    }
    
    //3.最多纪录10条  如果超过  移除 最后一位记录的数据
    int historyRecordMaxCount = 10;
    if(searchMutableArr.count > historyRecordMaxCount)
    {
        [searchMutableArr removeObjectAtIndex:historyRecordMaxCount];
    }
    
    
    //4.将上述数据全部存储到NSUserDefaults中
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:searchMutableArr forKey:KXHistoryRecordArr];
    [userDefaults synchronize];
    
    
//    NSArray *myArray = [[NSArray alloc] initWithArray:[userDefaultes arrayForKey:KXHistoryRecordArr]];
//    // NSArray --> NSMutableArray
//    NSMutableArray *searTXT = [NSMutableArray array];
//    searTXT = [myArray mutableCopy];
//    
//    BOOL isEqualTo1,isEqualTo2;
//    isEqualTo1 = NO,isEqualTo2 = NO;
//    
//    if (searTXT.count > 0) {
//        isEqualTo2 = YES;
//        //判断搜索内容是否存在，存在的话放到数组最后一位，不存在的话添加。
//        for (NSString * str in myArray) {
//            if ([currentCellStr isEqualToString:str]) {
//                //获取指定对象的索引
//                NSUInteger index = [myArray indexOfObject:currentCellStr];
//                [searTXT removeObjectAtIndex:index];
//                [searTXT insertObject:currentCellStr atIndex:0];
//                isEqualTo1 = YES;
//                break;
//            }
//        }
//    }
//    
//    if (!isEqualTo1 || !isEqualTo2) {
//        [searTXT insertObject:currentCellStr atIndex:0];
//    }
//    
//    if(searTXT.count > 10)
//    {
//        [searTXT removeObjectAtIndex:0];
//    }
//    
//    
//    //将上述数据全部存储到NSUserDefaults中
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    [userDefaults setObject:searTXT forKey:KXHistoryRecordArr];
//    [userDefaults synchronize];
}


#pragma mark --1.1 记录当前的 textField 中的文字
- (void)recordCurrentTextFieldStr:(NSString *)currentStr
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:currentStr forKey:KXCurrentTextFieldStr];
    [userDefaults synchronize];
}

#pragma mark -2.热门搜索 与 历史记录 View
- (void)setupHotHistoryView
{
    KXHotHistoryView * hotHistoryView = [[KXHotHistoryView alloc] initWithFrame:CGRectMake(0, 0, KXScreenW, KXScreenH)];
   hotHistoryView.sourceVC = @"one";
    [self.view addSubview:hotHistoryView];
   self.hotHistoryView = hotHistoryView;
}


#pragma mark -3.搜索结果 View
- (void)setupSearchResultView
{
    
}


#pragma mark -4.textField 搜索反馈页面
- (void)setupTextChangeView
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
