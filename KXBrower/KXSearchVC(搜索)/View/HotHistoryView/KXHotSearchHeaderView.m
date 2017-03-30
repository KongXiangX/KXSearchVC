//
//  KXHotSearchHeaderView.m
//  KXBrower
//
//  Created by apple on 17/3/24.
//  Copyright © 2017年 KXX. All rights reserved.
//

#import "KXHotSearchHeaderView.h"
#import "KXSearchHistoryCollectionCell.h"        //顶部collectionView 的 cell


@interface KXHotSearchHeaderView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView * collectionView;
//header里的collection
@property (nonatomic, strong) NSMutableArray * collectionArr;
//collection里面的数据

@end

@implementation KXHotSearchHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //0.网络请求
    
        NSUserDefaults * userDafaults = [NSUserDefaults standardUserDefaults];
        NSArray * arr = @[@"重庆火锅",@"蛋糕",@"冒菜",@"酸汤鱼",@"大盘鸡",@"麻辣烫",@"烧烤",@"自助餐",@"烤鸭"];
        [userDafaults setObject:arr forKey:KXHotSearchBackDataDic];
        [userDafaults synchronize];
        self.collectionArr = [NSMutableArray array];
        [self.collectionArr addObjectsFromArray:arr];
        
        //1.热门搜索
        UILabel * searchLab = [[UILabel alloc] init];
        searchLab.frame = CGRectMake(10, 0, KXScreenW, 40);
        searchLab.text = @"热门搜索";
        searchLab.backgroundColor = KXColor(245, 245, 245);
        searchLab.textColor = KXColor(183, 183, 183);
        searchLab.font = [UIFont boldSystemFontOfSize:16];
        searchLab.textAlignment = NSTextAlignmentLeft;
        [self addSubview:searchLab];
        
        
        //2.0.流 flow
        UICollectionViewFlowLayout * flowOut = [[UICollectionViewFlowLayout alloc] init];
        flowOut.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowOut.itemSize = CGSizeMake((KXScreenW - 5)/3, 40);
        flowOut.minimumLineSpacing = 1.0;
        flowOut.minimumInteritemSpacing = 1.0;
        //    flowOut.sectionInset = UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0);
        
        //2.1 collection
        UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, KXScreenW, 120) collectionViewLayout:flowOut];
        collectionView.backgroundColor = KXColor(230, 230, 230);
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [collectionView registerClass:[KXSearchHistoryCollectionCell class] forCellWithReuseIdentifier:KXSearchHistoryCollectionCellID];
        [self addSubview:collectionView];
        self.collectionView = collectionView;
    }
    return self;
}
#pragma mark - 网络请求上部按钮数据
//- (void)netWorkForData:(NSDictionary *) dic{
//    
//    NSUserDefaults * userDafaults = [NSUserDefaults standardUserDefaults];
//    self.collectionArr = [NSMutableArray array];
//    
//    NSString * url = [NSString stringWithFormat:@"%@m=Index&a=get_keywords",NetConnector];
//    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
//    [manager POST:url parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
//        
//        NSDictionary * dic = (NSDictionary *) responseObject;
//        if ([[dic objectForKey:@"err_code"] intValue] == 100) {
//            
//            
//            self.collectionArr = [dic objectForKey:@"data"];
//            [self.collectionView reloadData];
//            
//            
//            [userDafaults setObject:self.collectionArr forKey:QYHortSearchBackDataDic];
//            [userDafaults synchronize];
//            
//            
//        }else{
//            
//        }
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        //读取数组NSArray类型的数据
//        self.collectionArr = (NSMutableArray *)[[NSArray alloc] initWithArray:[userDafaults arrayForKey:QYHortSearchBackDataDic]];
//        
//        [self.collectionView reloadData];
//    }];
//}


#pragma mark -- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectionArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //1.赋值
    KXSearchHistoryCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:KXSearchHistoryCollectionCellID forIndexPath:indexPath];
    cell.lab.text = self.collectionArr[indexPath.row];
    
    return cell;
}

#pragma mark -- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    KXSearchHistoryCollectionCell * cell = (KXSearchHistoryCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if ([self.delegate respondsToSelector:@selector(hotSearchHeaderViewCollectionCellClick:)]) {
        [self.delegate hotSearchHeaderViewCollectionCellClick:cell.lab.text];
    }
    
}


@end
