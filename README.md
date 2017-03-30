# 
1.模仿美团 的搜索界面 跳转（2次跳转）

KXSearchVC                    //第一次跳转的 搜索界面
KXSearchResultVC              //第二次跳转的 搜索结果 界面

#宏定义的 几个字符串
1. KXHistoryRecordArr         //记录搜索的过的数据
2. KXCurrentTextFieldStr      //当前搜索词
3. KXHotSearchBackDataDic     //记录返回的 热门搜索 数据
4. KXPopTwoNotification       //跳转通知

#3个有关数据的 显示 View
1.  HotHistoryView                //热门搜索界面View
2.  SearchResultView              //搜索结果界面View
3.  SearchTextFieldChangeView     //搜索框反馈的列表

#Mark -- 1.思路
1.0  KXSearchVC --->  HotHistoryView （因为第二个界面KXSearchResultVC也用到 所以封装到 一个View）


2.0  KXSearchResultVC --->有上面的3个View
2.1  情况描述
     1. 第一进入 此页面    只显示  SearchResultView（搜索结果界面View）其他页面 隐藏
     2. 点击输入框 的时候  只显示  SearchTextFieldChangeView（搜索框反馈的列表）其他页面隐藏
     3. 输入框内容改变的   
        3.1 如果文本框 文字的长度 大于0  删除旧的SearchTextFieldChangeView，添加 新的SearchTextFieldChangeView。（也可以使用 通知实时 改变 SearchTextFieldChangeView 第一层的文字变化）
        3.2 如果文本框 文字的长度 等于0  只显示 HotHistoryView（热门搜索界面View）



3.1  HotHistoryView (热门搜索界面View)
        ---> UITableView（1个section） 
#        --->3.1.1  HeaderView 
            --->是一个封装了 一个label 与 UICollectionView 的View
            --->UICollectionView 注意里面有一个默认的数据 以及 内部有一个 网络请求

#        --->3.1.2. 自定义左图右文的Cell 
            注意：1. UserDeFault 保存最新的 搜索 文字  数据，最多保存 10个搜索记录
            2. 最新的搜索文字  插入到数组第一位[searTXT insertObject:currentCellStr atIndex:0];
            3. 如果 有记录 记得显示 table的cell个数多一个 显示  清除搜索记录




3.2  SearchResultView(搜索结果界面View)
     ---> UITableView（N个section）
#    --->3.2.1  HeaderView    
        ---> 一个简单封装的View （左图 右上： 标题  右中：星级  右下： 商铺类型）
#    --->3.2.2 cell 每个section 返回的Cell 个数是不固定的（）
#        ---> 0. 2种 cell 样式
                --->1. 展示商品具体描述的 cell 
                --->2. “查看其他（总个数 - 2）个团购” cell (大于等于3 个cell 的显示)


#       ---> 1. 获取所有数据的数据处理（_flagArray 用于判定 是否折叠，_sectionArray 返回的所有数据 数组）
            _flagArray  = [NSMutableArray array];
            for (int i = 0; i < 10; i ++) {

                    [_flagArray addObject:@"0"];
                    ........
                    .....

                    [_sectionArray addObject:dic];
            }


#        ---> 2. 大于2 个cell  只显示2个cell 第三个cell 显示 为"查看其他（总个数 - 2）个团购" ，点击该cell 展开该section中的全部cell  

#        ---> 3. 小于等于2个cell  显示cell  没有 “查看其他（总个数 - 2）个团购” cell 的显示




3.3  SearchTextFieldChangeView(搜索框反馈的列表)
    --->3.3.1.按钮  （按钮文字“搜索“”xxx“”）
    --->3.3.2.tableView
     
        --->情况描述 监听搜索 文本框 改变的时候 ，首先显示 
            --->1. 请求数据中 显示  提示按钮-- “搜索”XXXX”“ -->点击 跳转刷新数据  （更换textField 文字 ）
            --->1. 请求成功  隐藏   提示按钮 ，显示返回的数据





