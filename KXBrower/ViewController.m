//
//  ViewController.m
//  KXBrower
//
//  Created by apple on 17/3/14.
//  Copyright © 2017年 KXX. All rights reserved.
//

#import "ViewController.h"
#import "KXSearchVC.h"              //搜索 1 界面
#import "KXSearchResultVC.h"        //搜索 2 结果界面

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *sectionArray;
@property (nonatomic,strong)NSMutableArray *flagArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //4.按钮
    UIButton * statusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    statusBtn.frame = CGRectMake(100, 100, 50, 50);
    [statusBtn setTitle:@"查看退单进度" forState:UIControlStateNormal];
    statusBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    statusBtn.layer.cornerRadius = 5;
    statusBtn.layer.borderColor = [UIColor grayColor].CGColor;
    statusBtn.layer.borderWidth = 1;
    [statusBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [statusBtn addTarget:self action:@selector(statusBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:statusBtn];
    
    //5.如果是搜索页面  跳转另一个 搜索界面
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(popNotice) name:KXPopTwoNotification object:nil];
}
- (void)popNotice
{
    KXSearchResultVC * searchResultVC = [[KXSearchResultVC alloc] init];
//    searchResultVC.currntTextFieldStr = [[NSUserDefaults standardUserDefaults] objectForKey:QYCurrentTextFieldStr];
//    searchResultVC.currentCity = _city;
    [self.navigationController pushViewController:searchResultVC animated:YES];
    
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)statusBtnClick
{
    KXSearchVC * search = [[KXSearchVC alloc] init];
    search.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:search animated:YES];
}

/**
 *  处理数据  _sectionArray里面存储数组
 */
- (void)makeData{
    _sectionArray = [NSMutableArray array];
    _flagArray  = [NSMutableArray array];
    NSInteger num = 6;
    for (int i = 0; i < num; i ++) {
        NSMutableArray *rowArray = [NSMutableArray array];
        for (int j = 0; j < arc4random()%20 + 1; j ++) {
            [rowArray addObject:[NSString stringWithFormat:@"%d",j]];
        }
        [_sectionArray addObject:rowArray];
        [_flagArray addObject:@"0"];
        
    }
}
//设置组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _sectionArray.count;
}
//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = _sectionArray[section];
    return arr.count;
}
//组头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([_flagArray[indexPath.section] isEqualToString:@"0"]) {
        return 0;
    }else{
        return 44;
    }
    
}
//组头
// 定义头标题的视图，添加点击事件
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //    MyData *data = [dataArray objectAtIndex:section];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 320, 30);
    [btn setTitle:[NSString stringWithFormat:@"组%ld",(int)section] forState:UIControlStateNormal];
    btn.tag = section;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    if (section%2) {
        btn.backgroundColor = [UIColor darkGrayColor];
    }else{
        btn.backgroundColor = [UIColor lightGrayColor];
    }
    
    return btn;
}
- (void) btnClick:(UIButton *)btn
{
    //1.获取当前section的 用来加载section下面的cell的数组
    int index = btn.tag % 100;
    NSMutableArray *indexArray = [[NSMutableArray alloc]init];
    NSArray *arr = _sectionArray[index];
    for (int i = 0; i < arr.count; i ++) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:index];
        [indexArray addObject:path];
    }
    
    
    NSLog(@"%@",_flagArray[index]);
    //    展开
    if ([_flagArray[index] isEqualToString:@"0"]) {
        _flagArray[index] = @"1";
        [_tableView reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationBottom]; //从下滑入  //使用下面注释的方法就 注释掉这一句
    } else { //收起
        _flagArray[index] = @"0";
        [_tableView reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationTop]; //从上滑入   //使用下面注释的方法就 注释掉这一句
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identify];
    }
    cell.textLabel.text= [NSString stringWithFormat:@"第%d组的第%ld个cell",(int)indexPath.section,indexPath.row];
    cell.clipsToBounds = YES;//这句话很重要 不信你就试试</strong></span>
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
