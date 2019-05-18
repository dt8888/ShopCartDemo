//
//  CommonCell.h
//  YJApp
//
//  Created by DT on 2019/5/15.
//  Copyright © 2019年 dayukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CommonCell : UITableViewCell
@property(nonatomic,strong) CommonModel*model;
@property(nonatomic)BOOL isHaveAnimation;
@property(nonatomic,retain) NSIndexPath *indexPath;
@property(nonatomic,strong)UIButton*plusButton;
-(void)setItemNumber:(int)number addToItem:(BOOL)isAddItem;
@end

NS_ASSUME_NONNULL_END
