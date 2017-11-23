//
//  StatusCell.m
//  08.新浪微博
//
//  Created by 伍承标 on 2017/9/16.
//  Copyright © 2017年 伍承标. All rights reserved.
//

#import "StatusCell.h"
#import "StatusCellFrame.h"
#import "Status.h"
#import "User.h"
#import "IconView.h"
#import "UIImageView+WebCache.h"
#import "UIImage+MJ.h"
#import "ImageListView.h"
#import "Common.h"

@interface StatusCell()
{
    IconView *_icon; // 头像
    UILabel *_screenName; // 昵称
    UIImageView *_mbIcon; // 会员图标
    UILabel *_time; // 时间
    UILabel *_source; // 来源
    UILabel *_text; // 内容
    ImageListView *_image; // 配图
    
    UIImageView *_retweeted; // 被转发微博的父控件
    UILabel *_retweetedScreenName; // 被转发微博作者的昵称
    UILabel *_retweetedText; // 被转发微博的内容
    ImageListView *_retweetedImage; // 被转发微博的配图
}
@end

@implementation StatusCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 1.添加微博本身的子控件
        [self addAllSubviews];
        
        // 2.添加被转发微博的子控件
        [self addReweetedAllSubviews];
    }
    return self;
}

#pragma mark 添加微博本身的子控件
- (void)addAllSubviews
{
    // 1.头像
    _icon = [[IconView alloc] init];
    [self.contentView addSubview:_icon];
    
    // 2.昵称
    _screenName = [[UILabel alloc] init];
    _screenName.font = kScreenNameFont;
    _screenName.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_screenName];
    
    // 皇冠图标
    _mbIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_membership.png"]];
    [self.contentView addSubview:_mbIcon];
    
    // 3.时间
    _time = [[UILabel alloc] init];
    _time.font = kTimeFont;
    _time.textColor = kColor(246, 165, 68);
    _time.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_time];
    
    // 4.来源
    _source = [[UILabel alloc] init];
    _source.font = kSourceFont;
    _source.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_source];
    
    // 5.内容
    _text = [[UILabel alloc] init];
    _text.numberOfLines = 0;
    _text.font = kTextFont;
    _text.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_text];
    
    // 6.配图
    _image = [[ImageListView alloc] init];
    [self.contentView addSubview:_image];
}

#pragma mark 被转发微博的子控件
- (void)addReweetedAllSubviews
{
    // 1.被转发微博的父控件
    _retweeted = [[UIImageView alloc] init];
    _retweeted.image = [UIImage resizedImage:@"timeline_retweet_background.png" xPos:0.9 yPos:0.5];
    [self.contentView addSubview:_retweeted];
    
    // 2.被转发微博的昵称
    _retweetedScreenName = [[UILabel alloc] init];
    _retweetedScreenName.font = kRetweetedScreenNameFont;
    _retweetedScreenName.textColor = kRetweetedScreenNameColor;
    _retweetedScreenName.backgroundColor = [UIColor clearColor];
    [_retweeted addSubview:_retweetedScreenName];
    
    // 3.被转发微博的内容
    _retweetedText = [[UILabel alloc] init];
    _retweetedText.numberOfLines = 0;
    _retweetedText.font = kRetweetedTextFont;
    _retweetedText.backgroundColor = [UIColor clearColor];
    [_retweeted addSubview:_retweetedText];
    
    // 4.被转发微博的配图
    _retweetedImage = [[ImageListView alloc] init];
    [_retweeted addSubview:_retweetedImage];
}

- (void)setStatusCellFrame:(StatusCellFrame *)statusCellFrame
{
    _statusCellFrame = statusCellFrame;
    
    Status *s = statusCellFrame.status;
    
    // 1.头像
    _icon.frame = statusCellFrame.iconFrame;
    [_icon setUser:s.user type:kIconTypeSmall];
    //    _icon.type = kIconTypeSmall;
    //    _icon.user = s.user;
    //    [_icon setImageWithURL:[NSURL URLWithString:s.user.profileImageUrl] placeholderImage:[UIImage imageNamed:@"Icon.png"] options:SDWebImageRetryFailed | SDWebImageLowPriority];
    
    // 2.昵称
    _screenName.frame = statusCellFrame.screenNameFrame;
    _screenName.text = s.user.screenName;
    // 判断是不是会员
    if (s.user.mbtype == kMBTypeNone) {
        _screenName.textColor = kScreenNameColor;
        _mbIcon.hidden = YES;
    } else {
        _screenName.textColor = kMBScreenNameColor;
        _mbIcon.hidden = NO;
        _mbIcon.frame = statusCellFrame.mbIconFrame;
    }
    
    // 3.时间
    _time.text = s.createdAt;
    CGFloat timeX = statusCellFrame.screenNameFrame.origin.x;
    CGFloat timeY = CGRectGetMaxY(statusCellFrame.screenNameFrame) + kCellBorderWidth;
    CGSize timeSize = [_time.text sizeWithFont:kTimeFont];
    _time.frame = (CGRect){{timeX, timeY}, timeSize};
    
    // 4.来源
    _source.text = s.source;
    CGFloat sourceX = CGRectGetMaxX(_time.frame) + kCellBorderWidth;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [_source.text sizeWithFont:kSourceFont];
    _source.frame = (CGRect) {{sourceX, sourceY}, sourceSize};
    
    // 5.内容
    _text.frame = statusCellFrame.textFrame;
    _text.text = s.text;
    
    // 6.配图
    if (s.picUrls.count) {
        _image.hidden = NO;
        _image.frame = statusCellFrame.imageFrame;
        _image.imageUrls = s.picUrls;
        //        MyLog(@"pic---%@", s.picUrls);
        //        NSString *imageStr = s.picUrls[0][@"thumbnail_pic"];
        //        NSURL *imageURL = [NSURL URLWithString:imageStr];
        //        [_image setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"Icon.png"] options:SDWebImageLowPriority | SDWebImageRetryFailed];
        //#warning 配图的图片
    } else {
        _image.hidden = YES;
    }
    
    // 7.被转发微博
    if (s.retweetedStatus) {
        _retweeted.hidden = NO;
        
        _retweeted.frame = statusCellFrame.retweetedFrame;
        
        // 8.昵称
        _retweetedScreenName.frame = statusCellFrame.retweetedScreenNameFrame;
        _retweetedScreenName.text = [NSString stringWithFormat:@"@%@", s.retweetedStatus.user.screenName];
        
        // 9.内容
        _retweetedText.frame = statusCellFrame.retweetedTextFrame;
        _retweetedText.text = s.retweetedStatus.text;
        
        // 10.配图
        if (s.retweetedStatus.picUrls.count) {
            _retweetedImage.hidden = NO;
            
            _retweetedImage.frame = statusCellFrame.retweetedImageFrame;
            
            _retweetedImage.imageUrls = s.retweetedStatus.picUrls;
            //            [_retweetedImage setImageWithURL:[NSURL URLWithString:s.retweetedStatus.picUrls[0][@"thumbnail_pic"]] placeholderImage:[UIImage imageNamed:@"Icon.png"] options:SDWebImageRetryFailed | SDWebImageLowPriority];
            
        } else {
            _retweetedImage.hidden = YES;
        }
    } else {
        _retweeted.hidden = YES;
    }
    
}
@end
