//
//  User.m
//  08.新浪微博
//
//  Created by 伍承标 on 2017/9/12.
//  Copyright © 2017年 伍承标. All rights reserved.
//

#import "User.h"

@implementation User
- (id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.screenName = dict[@"screen_name"];
        self.profileImageUrl = dict[@"profile_image_url"];
        
        self.verified = [dict[@"verified"] boolValue];
        self.verifiedType = [dict[@"verified_type"] intValue];
        self.mbrank = [dict[@"mbrank"] intValue];
        self.mbtype = [dict[@"mbtype"] intValue];
    }
    return self;
}
@end
