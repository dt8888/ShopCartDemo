//
//  ShopCartView.h
//  YJApp
//
//  Created by DT on 2019/5/14.
//  Copyright © 2019年 dayukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowCartTableView.h"
#import "ViewController.h"
NS_ASSUME_NONNULL_BEGIN


@interface ShopCartView : UIView<UITableViewDelegate,addDeleteItemDelegate>
@property (nonatomic,strong) NSString *badgeValue;
@property(nonatomic,strong)  UIImageView *imageView;
@property(nonatomic,strong)NSObject *attribute;
- (instancetype)initWithFrame:(CGRect)frame attribute:(NSObject *)attribute storeID:(int)storeId storeName:(NSString*)storeName;
@property (nonatomic,strong) void (^callBackYJDetailViewController)(CGFloat );

@property(nonatomic,strong) ShowCartTableView*tableView;
@end

NS_ASSUME_NONNULL_END
