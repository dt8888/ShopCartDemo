//
//  ShowCartTableView.h
//  YJApp
//
//  Created by DT on 2019/5/16.
//  Copyright © 2019年 dayukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShowCartTableView : UITableView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSArray*sectionArray;

@end

NS_ASSUME_NONNULL_END
