//
//  StatusTool.h
//  08.新浪微博
//
//  Created by 伍承标 on 2017/9/12.
//  Copyright © 2017年 伍承标. All rights reserved.
//

#import <Foundation/Foundation.h>

// statues装的都是Status对象
typedef void (^StatusSuccessBlock)(NSArray *statues);
typedef void (^StatusFailureBlock)(NSError *error);

@interface StatusTool : NSObject
+ (void)statusesWithSuccess:(StatusSuccessBlock)success failure:(StatusFailureBlock)failure;
@end
