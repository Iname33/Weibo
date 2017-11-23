//
//  ViewController.m
//  08.新浪微博
//
//  Created by 伍承标 on 2017/8/30.
//  Copyright © 2017年 伍承标. All rights reserved.
//

#import "ViewController.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "MeViewController.h"
#import "SquearViewController.h"
#import "MoreViewController.h"
#import "Mybutton.h"
#define Height [UIScreen mainScreen].bounds.size.height
#define Width [UIScreen mainScreen].bounds.size.width
@interface ViewController ()
@property (strong, nonatomic) NSArray* titles;
@property (strong, nonatomic) NSArray* imgNames;
@property (strong, nonatomic) NSArray* selectImgNames;
@property (strong, nonatomic) UIButton* beforeBtn;
@end

@implementation ViewController
-(NSArray *)titles{
    if (!_titles) {
        _titles = @[@"首页",@"消息",@"我",@"广场",@"更多"];
    }
    return _titles;
}
-(NSArray *)imgNames{
    if (!_imgNames) {
        _imgNames = @[@"tabbar_home@2x",@"tabbar_message_center@2x",@"tabbar_profile@2x",@"tabbar_discover@2x",@"tabbar_more@2x"];
    }
    return _imgNames;
}

-(NSArray *)selectImgNames{
    if (!_selectImgNames) {
        _selectImgNames = @[@"tabbar_home_selected@2x",@"tabbar_message_center_selected@2x",@"tabbar_profile_selected@2x",@"tabbar_discover_selected@2x",@"tabbar_more_selected@2x"];
    }
    return _selectImgNames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.hidden=YES;
    [self createTabBarView];
    [self createChildView];
}

-(void)createTabBarView{
    self.tabBarView=[[UIView alloc]init];
    self.tabBarView.frame=CGRectMake(0, Height-44, Width, 44);
    self.tabBarView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background@2x"]];
    [self.view addSubview:self.tabBarView];
    for (int i=0; i<5; i++) {
        Mybutton*button = [[Mybutton alloc]init];
        CGFloat btnW=Width/5;
        CGFloat btnH=42;
        CGFloat btnX=i*btnW;
        CGFloat btnY=(44-42)/2;
        button.frame=CGRectMake(btnX, btnY, btnW, btnH);
        
        [button setTitle:self.titles[i] forState:(UIControlStateNormal)];
        
        [button setImage:[UIImage imageNamed:self.imgNames[i]] forState:(UIControlStateNormal)];
        
        [button setImage:[UIImage imageNamed:self.selectImgNames[i]] forState:(UIControlStateSelected)];
        
        [button addTarget:self action:@selector(changeView:) forControlEvents:(UIControlEventTouchUpInside)];
        button.tag=i;
        if (i==0) {
            button.selected=YES;
            self.beforeBtn=button;
        }
        [self.tabBarView addSubview:button];
    }
}

-(void)createChildView{
    HomeViewController* hvc = [[HomeViewController alloc]init];
    MessageViewController* mvc = [[MessageViewController alloc]init];
    MeViewController* mevc = [[MeViewController alloc]init];
    SquearViewController*qvc = [[SquearViewController alloc]init];
    MoreViewController* movc = [[MoreViewController alloc]initWithStyle:(UITableViewStyleGrouped)];
    NSArray* views = @[hvc,mvc,mevc,qvc,movc];
    NSMutableArray*allvc=[NSMutableArray array];
    for (int i=0; i<5; i++) {
        UINavigationController*navi=[[UINavigationController alloc]initWithRootViewController:views[i]];
        [allvc addObject:navi];
    }
    self.viewControllers=allvc;
}

-(void)changeView:(UIButton*)sender{
    self.selectedIndex = sender.tag;
    self.beforeBtn.selected = NO;
    sender.selected = YES;
    self.beforeBtn = sender;
}




@end






