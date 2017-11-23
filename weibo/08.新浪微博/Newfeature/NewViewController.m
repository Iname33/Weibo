//
//  NewViewController.m
//  08.新浪微博
//
//  Created by 伍承标 on 2017/9/3.
//  Copyright © 2017年 伍承标. All rights reserved.
//

#import "NewViewController.h"
#import "ViewController.h"
#import "OauthController.h"
@interface NewViewController ()<UIScrollViewDelegate>
@property (strong, nonatomic) UIWebView* webView;
@property (strong ,nonatomic) UIPageControl*page;

@end

@implementation NewViewController

-(void)loadView{
    UIImageView*imageView=[[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    imageView.image=[UIImage imageNamed:@"new_feature_background"];
    imageView.userInteractionEnabled=YES;
    self.view=imageView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self createP];
    
    
}


-(void)createP{
    UIScrollView *scroll=[[UIScrollView alloc]init];
    scroll.frame=self.view.bounds;
    scroll.delegate=self;
    scroll.showsHorizontalScrollIndicator=NO;
    CGSize size = scroll.frame.size;
    scroll.contentSize=CGSizeMake(size.width*4, 0);
    scroll.pagingEnabled=YES;
    [self.view addSubview:scroll];
    
    
    for (int i=0; i<4; i++) {
        UIImageView *imageView =[[UIImageView alloc]init];
        NSString*name=[NSString stringWithFormat:@"new_feature_%d@2x",i+1];
        imageView.image=[UIImage imageNamed:name];
        imageView.frame=CGRectMake(i*size.width, 0, size.width, size.height);
        [scroll addSubview:imageView];
        
        if (i==3) {
            UIButton*start=[UIButton buttonWithType:UIButtonTypeCustom];
            UIImage*stnom1 =[UIImage imageNamed:@"new_feature_finish_button"];
            [start setBackgroundImage:stnom1 forState:UIControlStateNormal];
            [start setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted@2x"] forState:(UIControlStateHighlighted)];
            start.center=CGPointMake(size.width*0.5, size.height*0.8);
            start.bounds=CGRectMake(0, 0, stnom1.size.width, stnom1.size.height);
            [start addTarget:self action:@selector(start) forControlEvents:(UIControlEventTouchUpInside)];
            [imageView addSubview:start];
            
            
            
            UIButton*share=[UIButton buttonWithType:UIButtonTypeCustom];
            
            UIImage*stnom =[UIImage imageNamed:@"new_feature_share_false@2x"];
            [share setBackgroundImage:stnom forState:UIControlStateNormal];
            
            [share setBackgroundImage:[UIImage imageNamed:@"new_feature_share_true@2x"] forState:(UIControlStateSelected)];
            
            share.center=CGPointMake(start.center.x ,start.center.y-50);
            share.bounds=CGRectMake(0, 0, stnom.size.width, stnom.size.height);
            [share addTarget:self action:@selector(share:) forControlEvents:(UIControlEventTouchDragInside)];
            
            share.selected=YES;
            share.adjustsImageWhenHighlighted=NO;
            [imageView addSubview:share];
            
            
            imageView.userInteractionEnabled=YES;
        }
    }
    
    UIPageControl*page=[[UIPageControl alloc]init];
    page.center= CGPointMake(size.width*0.5, size.height*0.95);
    page.bounds= CGRectMake(0, 0, 150, 0);
    page.numberOfPages=4;
    page.currentPageIndicatorTintColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_checked_point"]];
    page.pageIndicatorTintColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_point@2x"]];
    [self.view addSubview:page];
    _page=page;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _page.currentPage= scrollView.contentOffset.x/scrollView.frame.size.width;
    
}


-(void)start{
    NSLog(@"开始微博");
    self.view.window.rootViewController=[[OauthController alloc]init];
}


-(void)share:(UIButton*)bt{
    bt.selected=!bt.selected;
    
}

-(void)dealloc{
    
}

@end
