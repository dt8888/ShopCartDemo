//
//  ShowCartCell.h
//  YJApp
//
//  Created by DT on 2019/5/16.
//  Copyright © 2019年 dayukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ShowCartCell : UITableViewCell
@property(nonatomic,strong)CommonModel*model;
@property(nonatomic,retain) NSIndexPath *indexPath;
@end

NS_ASSUME_NONNULL_END
