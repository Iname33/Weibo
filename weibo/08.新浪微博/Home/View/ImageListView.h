//
//  ImageListView.h
//  08.新浪微博
//
//  Created by 伍承标 on 2017/9/20.
//  Copyright © 2017年 伍承标. All rights reserved.
//配图列表

#import <UIKit/UIKit.h>

@interface ImageListView : UIView

@property(nonatomic,strong)NSArray*imageUrls;

+ (CGSize)imageListSizeWithCount:(int)count;
@end
