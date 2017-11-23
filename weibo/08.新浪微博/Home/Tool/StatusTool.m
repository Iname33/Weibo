//
//  StatusTool.m
//  08.新浪微博
//
//  Created by 伍承标 on 2017/9/12.
//  Copyright © 2017年 伍承标. All rights reserved.
//

#import "StatusTool.h"
#import "HttpTool.h"
#import "AccountTool.h"
#import "Status.h"
@implementation StatusTool

+ (void)statusesWithSuccess:(StatusSuccessBlock)success failure:(StatusFailureBlock)failure
{
    [HttpTool getWithPath:@"2/statuses/home_timeline.json" params:nil success:^(id JSON) {
        if (success == nil) return;
        
        NSMutableArray *statuses = [NSMutableArray array];
        
        // 解析json对象
        NSArray *array = JSON[@"statuses"];
        for (NSDictionary *dict in array) {
            Status *s = [[Status alloc]initWinthDic:dict];
            [statuses addObject:s];
        }
        
        // 回调block
        success(statuses);
    } failure:^(NSError *error) {
        if (failure == nil) return;
        
        failure(error);
    }];
}
@end
