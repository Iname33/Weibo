//
//  IconView.h
//  08.新浪微博
//
//  Created by 伍承标 on 2017/9/18.
//  Copyright © 2017年 伍承标. All rights reserved.
//
#define kIconSmallW 34
#define kIconSmallH 34

#define kIconDefaultW 50
#define kIconDefaultH 50

#define kIconBigW 85
#define kIconBigH 85

#define kVertifyW 18
#define kvertifyH 18

#import <UIKit/UIKit.h>
typedef enum {
    kIconTypeSmall,
    kIconTypeDefault,
    kIconTypeBig
} IconType;
@class User;
@interface IconView : UIView
@property(nonatomic,strong)User*user;

@property(nonatomic,assign)IconType type;

- (void)setUser:(User *)user type:(IconType)type;

+ (CGSize)iconSizeWithType:(IconType)type;


@end
