//
//  Status.m
//  08.新浪微博
//
//  Created by 伍承标 on 2017/9/12.
//  Copyright © 2017年 伍承标. All rights reserved.
//

#import "Status.h"
#import "User.h"

@implementation Status

-(id)initWinthDic:(NSDictionary*)dict
{
    if (self = [super init]) {
        self.text = dict[@"text"];
        self.user = [[User alloc] initWithDict:dict[@"user"]];
        self.picUrls = dict[@"pic_urls"];
        
        NSDictionary *retweet = dict[@"retweeted_status"];
        if (retweet) {
            self.retweetedStatus = [[Status alloc] initWinthDic:retweet];
        }
        
        self.createdAt = dict[@"created_at"];
        self.source = dict[@"source"];
        
        self.repostsCount = [dict[@"reposts_count"] intValue];
        self.commentsCount = [dict[@"comments_count"] intValue];
        self.attitudesCount = [dict[@"attitudes_count"] intValue];
    }
    return self;
}

- (NSString *)createdAt
{
    // Sat Nov 02 15:08:27 +0800 2013
    //    MyLog(@"%@", _createdAt);
    // 1.将新浪时间字符串转为NSDate对象
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss zzzz yyyy";
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDate *date = [fmt dateFromString:_createdAt];
    
    // 2.获得当前时间
    NSDate *now = [NSDate date];
    
    // 3.获得当前时间和微博发送时间的间隔（差多少秒）
    NSTimeInterval delta = [now timeIntervalSinceDate:date];
    
    // 4.根据时间间隔算出合理的字符串
    if (delta < 60) { // 1分钟内
        return @"刚刚";
    } else if (delta < 60 * 60) { // 1小时内
        return [NSString stringWithFormat:@"%.f分钟前", delta/60];
    } else if (delta < 60 * 60 * 24) { // 1天内
        return [NSString stringWithFormat:@"%.f小时前", delta/60/60];
    } else {
        fmt.dateFormat = @"MM-dd HH:mm";
        return [fmt stringFromDate:date];
    }
}

//- (NSString *)source
//{
//    MyLog(@"source00000000");
//
//    int begin = [_source rangeOfString:@">"].location + 1;
//    int end = [_source rangeOfString:@"</"].location;
//
//    return [NSString stringWithFormat:@"来自%@", [_source substringWithRange:NSMakeRange(begin, end - begin)]];
//}

- (void)setSource:(NSString *)source
{
    NSLog(@"setSource");
    // <a href="http://app.weibo.com/t/feed/2qiXeb" rel="nofollow">好保姆</a>
    //    MyLog(@"%@", _source);
    
    int begin = [source rangeOfString:@">"].location + 1;
    int end = [source rangeOfString:@"</"].location;
    
    _source = [NSString stringWithFormat:@"来自%@", [source substringWithRange:NSMakeRange(begin, end - begin)]];
}
@end
