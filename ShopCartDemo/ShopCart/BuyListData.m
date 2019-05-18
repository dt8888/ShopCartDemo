//
//  BuyListData.m
//  YJApp
//
//  Created by DT on 2019/5/16.
//  Copyright © 2019年 dayukeji. All rights reserved.
//

#import "BuyListData.h"

static BuyListData *data=nil;
@implementation BuyListData
+(BuyListData*)shareBuyListData
{
    @synchronized(self){
        if (data == nil) {
            data = [[BuyListData alloc] initWith];
        }
    }
    return data;
}

-(instancetype)initWith
{
    self = [super init];
    if (self) {
        _buyDataArray = [[NSMutableArray alloc]init];
    }
    return self;
}

-(void)reset
{
    if (_buyDataArray.count>0)
        [_buyDataArray removeAllObjects];
}

- (void)removeObjectAtIndex:(NSUInteger)objectIndex
{
    if(_buyDataArray.count>objectIndex){
        [_buyDataArray removeObjectAtIndex:objectIndex];
    }
}
- (id)objectAtIndex:(NSUInteger)objectIndex
{
    if(_buyDataArray.count>objectIndex){
        return [_buyDataArray objectAtIndex:objectIndex];
    }
    return nil;
}

- (int)getCount
{
    return (int)_buyDataArray.count;
}

- (void)addObject:(id)object
{
    [_buyDataArray addObject:object];
}

- (void)removeObject:(id)object
{
    [_buyDataArray removeObject:object];
}
@end
