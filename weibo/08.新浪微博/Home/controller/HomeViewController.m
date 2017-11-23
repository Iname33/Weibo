//
//  HomeViewController.m
//  08.新浪微博
//
//  Created by 伍承标 on 2017/8/30.
//  Copyright © 2017年 伍承标. All rights reserved.
//

#import "HomeViewController.h"
#import "UIBarButtonItem+MJ.h"
#import "AccountTool.h"
#import "StatusTool.h"
#import "Status.h"
#import "User.h"
#import "UIImageView+WebCache.h"
#import "StatusCellFrame.h"
#import "StatusCell.h"

@interface HomeViewController ()
{
    NSMutableArray *_statusFrames;
}
@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.设置界面属性
    [self buildUI];
    
    // 2.获得用户的微博数据
    [self loadStatusData];
}

#pragma mark 加载微博数据
- (void)loadStatusData
{
    _statusFrames = [NSMutableArray array];
    
    // 获取微博数据
    [StatusTool statusesWithSuccess:^(NSArray *statues){
        // 1.在拿到最新微博数据的同时计算它的frame
        for (Status *s in statues) {
            StatusCellFrame *f = [[StatusCellFrame alloc] init];
            f.status = s;
            [_statusFrames addObject:f];
        }
        
        // 2.刷新表格
        [self.tableView reloadData];
    } failure:nil];
}

#pragma mark 设置界面属性
- (void)buildUI
{
    // 1.设置标题
    self.title = @"首页";
    
    // 2.左边的item
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_compose.png" highlightedIcon:@"navigationbar_compose_highlighted.png" target:self action:@selector(sendStatus)];
    
    // 3.右边的item
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_pop.png" highlightedIcon:@"navigationbar_pop_highlighted.png" target:self action:@selector(popMenu)];
    
    // 4.背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark 发微博
- (void)sendStatus
{
    NSLog(@"发微博");
}

#pragma mark 弹出菜单
- (void)popMenu
{
    NSLog(@"弹出菜单");
}

// 刷新数据：重新访问数据源，重新给数据源和代理发送所有需要的消息（重新调用数据源和代理所有需要的方法）
//    [tableView reloadData];

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _statusFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    StatusCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[StatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.statusCellFrame = _statusFrames[indexPath.row];
    
    return cell;
}

#pragma mark - tableView delaget methods
#pragma mark 返回每一行cell的高度 每次tableView刷新数据的时候都会调用
// 而且会一次性算出所有cell的高度，比如有100条数据，一次性调用100次
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [_statusFrames[indexPath.row] cellHeight];
}
@end
