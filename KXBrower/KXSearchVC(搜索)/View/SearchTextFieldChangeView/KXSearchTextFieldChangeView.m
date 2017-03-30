//
//  KXSearchTextFieldChangeView.m
//  KXBrower
//
//  Created by apple on 17/3/29.
//  Copyright © 2017年 KXX. All rights reserved.
//

#import "KXSearchTextFieldChangeView.h"

@interface KXSearchTextFieldChangeView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray *tablViewArr;

@property (nonatomic, strong) UIButton * searchAlertBtn;
@property (nonatomic, strong) UIImageView * barImg;         //分割线
@end

@implementation KXSearchTextFieldChangeView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //1.显示搜索提示
        [self setupSearchAlertBtn];
        
        //2.数据
        [self makeData];
        //3.初始化
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KXScreenW, KXScreenH -KXNavBarH) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.hidden = YES;
        [self addSubview:_tableView];
    }
    return self;
}

#pragma mark - 1.显示搜索提示
- (void)setupSearchAlertBtn
{
    
    //1.按钮
    UIButton * searchAlertBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchAlertBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    searchAlertBtn.frame = CGRectMake(0, 0, KXScreenW, 40);
    
    [searchAlertBtn addTarget:self action:@selector(searchAlertBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:searchAlertBtn];
    self.searchAlertBtn = searchAlertBtn;
    
    //2.分割线
    UIImageView * barImg = [[UIImageView alloc] init];
    barImg.frame = CGRectMake(0, 40 -1 , KXScreenW, 1);
    barImg.backgroundColor = KXColor(230, 230, 230);
    [searchAlertBtn addSubview:barImg];
    self.barImg = barImg;
    
}
- (void)searchAlertBtnClick
{
    //1.网络请求
    //1.1 请求数据中 显示  提示按钮-- “搜索”XXXX”“ -->点击 跳转刷新数据  （更换textField 文字 ）
    //1.2 请求成功  隐藏   提示按钮 ，显示返回的数据
    self.searchAlertBtn.hidden = YES;
    self.tableView.hidden = NO;
    [self hideKeyBoard];
    [self.tableView reloadData];
    //1.3 请求失败  提示失败
    
    
    
//    if ([self.delegate respondsToSelector:@selector(tapChangViewCellWithStr:)]) {
//        [self.delegate tapChangViewCellWithStr:self.currentEdtingStr];
//    }
    
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    //1.文字
    NSString * btnStr = [NSString stringWithFormat:@"搜索“%@”",self.currentEdtingStr];
    [self.searchAlertBtn setTitle:btnStr forState:UIControlStateNormal];
    
    //2.分割线
    
}



/**
 *  处理数据  _sectionArray里面存储数组
 */
- (void)makeData{
    
    
    _tablViewArr = [NSMutableArray array];
    
    NSInteger num = 6;
    for (int i = 0; i < num; i ++) {
        NSMutableArray *rowArray = [NSMutableArray array];
        for (int j = 0; j < arc4random()%20 + 1; j ++) {
            [rowArray addObject:[NSString stringWithFormat:@"%d",j]];
        }
        [_tablViewArr addObject:rowArray];
    }
}

//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tablViewArr.count;
}

//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identify];
    }
    cell.textLabel.text= @"搜索结果";
    cell.imageView.image = [UIImage imageNamed:@"放大镜"];
    cell.clipsToBounds = YES;//这句话很重要 不信你就试试</strong></span>
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if ([self.delegate respondsToSelector:@selector(tapChangViewCellWithStr:)]) {
        [self.delegate tapChangViewCellWithStr:cell.textLabel.text];
    }
}
#pragma mark - 3.其他
#pragma mark -- 3.0  UIScrollViewDelegate -滑动的时候 隐藏键盘
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self hideKeyBoard];
}

- (void)hideKeyBoard
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

@end
