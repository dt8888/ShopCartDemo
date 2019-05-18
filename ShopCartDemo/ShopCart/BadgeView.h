//
//  BadgeView.h
//  YJApp
//
//  Created by DT on 2019/5/14.
//  Copyright © 2019年 dayukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BadgeView : UIView
-(instancetype)initWithFrame:(CGRect)frame withString:(NSString *)string;

-(instancetype)initWithFrame:(CGRect)frame withString:(NSString *)string withTextColor:(UIColor *)textColor;

@property (nonatomic,strong) NSString *badgeValue;
@end

NS_ASSUME_NONNULL_END
