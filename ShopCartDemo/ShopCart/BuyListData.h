//
//  BuyListData.h
//  YJApp
//
//  Created by DT on 2019/5/16.
//  Copyright © 2019年 dayukeji. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BuyListData : NSObject
@property(nonatomic,strong)NSMutableArray *buyDataArray;
- (instancetype)initWith;
- (void)reset;
- (void)removeObjectAtIndex:(NSUInteger)objectIndex;
- (id)objectAtIndex:(NSUInteger)objectIndex;
- (int)getCount;
- (void)addObject:(id)object;
- (void)removeObject:(id)object;
+ (BuyListData*)shareBuyListData;
@end
#define BUYLISTDATA [BuyListData shareBuyListData]
NS_ASSUME_NONNULL_END
