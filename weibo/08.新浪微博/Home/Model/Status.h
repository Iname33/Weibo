//
//  Status.h
//  08.新浪微博
//
//  Created by 伍承标 on 2017/9/12.
//  Copyright © 2017年 伍承标. All rights reserved.
//

#import <Foundation/Foundation.h>
@class User;
@interface Status : NSObject
@property(nonatomic,copy)NSString*text;//微博内容
@property(nonatomic,strong)User*user;//微博用户
@property(strong,nonatomic)NSArray*picUrls;//微博配图
@property(strong,nonatomic)Status * retweetedStatus;//被转发的微博

@property(nonatomic,copy)NSString* createdAt;//创建时间
@property(nonatomic,assign)int repostsCount;//转发数
@property(nonatomic,assign)int commentsCount;//评论数
@property(nonatomic,assign)int attitudesCount;//表态数
@property(nonatomic,copy)NSString * source;//微博来源

-(id)initWinthDic:(NSDictionary*)dict;
@end


