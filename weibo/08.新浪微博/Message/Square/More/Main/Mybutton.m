//
//  Mybutton.m
//  08.新浪微博
//
//  Created by 伍承标 on 2017/8/30.
//  Copyright © 2017年 伍承标. All rights reserved.
//

#import "Mybutton.h"

@implementation Mybutton

-(instancetype)init{
    if (self=[super init]) {
        self.titleLabel.font=[UIFont systemFontOfSize:12];
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        self.imageView.contentMode=UIViewContentModeCenter;
    }
    return self;
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat x=0;
    CGFloat width=self.frame.size.width;
    CGFloat y=self.frame.size.height*0.7;
    CGFloat height=self.frame.size.height*0.3;
    return CGRectMake(x, y, width, height);
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat x=0;
    CGFloat y=0;
    CGFloat height=self.frame.size.height*0.7;
    CGFloat width=self.frame.size.width;
    
    return  CGRectMake(x, y, width, height);
}

@end
