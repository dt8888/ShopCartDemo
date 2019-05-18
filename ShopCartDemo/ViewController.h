//
//  ViewController.h
//  ShopCartDemo
//
//  Created by 董婷 on 2019/5/17.
//  Copyright © 2019年 DT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonTableView.h"

@protocol addDeleteItemDelegate<NSObject>
- (void)addDeleteItem:(CGFloat)totalPriceNumber;
@end

@interface ViewController : UIViewController
@property(nonatomic,strong)CommonTableView*tableView;
@property(nonatomic,weak)id<addDeleteItemDelegate>delegateShoppingCart;
@end

