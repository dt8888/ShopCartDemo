//
//  CommonTableView.m
//  YJApp
//
//  Created by DT on 2019/5/15.
//  Copyright © 2019年 dayukeji. All rights reserved.
//

#import "CommonTableView.h"
#import "CommonCell.h"
#import "CommonModel.h"
@implementation CommonTableView
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self!=nil) {
        self.delegate = self;
        self.dataSource = self;
        self.tableFooterView = [[UIView alloc]init];
        self.backgroundColor = [UIColor whiteColor];
        self.separatorStyle = NO;
        self.separatorColor = deputyMainPageColor;
        self.separatorInset = UIEdgeInsetsMake(0,10, 0, 10);        // 设置端距，这里表示separator离左边和右边均80像素
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return self;
}
-(void)setSectionArray:(NSArray *)sectionArray
{
    if(sectionArray!=nil){
        _sectionArray  = sectionArray;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _sectionArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
       CommonModel *model = self.sectionArray[indexPath.row];
      return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    CommonCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[CommonCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    CommonModel *model = self.sectionArray[indexPath.row];
    cell.model = model;
    cell.indexPath = indexPath;
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"scrollViewIndex" object:nil];
}
@end
