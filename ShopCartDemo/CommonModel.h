//
//  CommonModel.h
//  YJApp
//
//  Created by DT on 2019/5/15.
//  Copyright © 2019年 dayukeji. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonModel : NSObject
@property(nonatomic,strong)NSString* itemName;
@property(nonatomic,strong)NSString* mainImgUrl;
@property(nonatomic,assign)CGFloat  price;
@property(nonatomic,assign)int count;
@property(nonatomic,assign)int itemId;
@property(nonatomic,assign)CGFloat  rebatePrice;
@property(nonatomic,assign)CGFloat yjPrice;
@property(nonatomic,assign)int  sales;
@property(nonatomic,assign)int sysl;
@property(nonatomic,strong)NSNumber* cellHight;
@property(nonatomic,strong)UITableViewCell*cell;

@end

NS_ASSUME_NONNULL_END
