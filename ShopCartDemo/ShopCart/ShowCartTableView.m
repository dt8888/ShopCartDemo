//
//  ShowCartTableView.m
//  YJApp
//
//  Created by DT on 2019/5/16.
//  Copyright © 2019年 dayukeji. All rights reserved.
//

#import "ShowCartTableView.h"
#import "CommonModel.h"
#import "ShowCartCell.h"
@implementation ShowCartTableView
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self!=nil) {
        self.delegate = self;
        self.dataSource = self;
//        self.tableFooterView = [self footerView];
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _sectionArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    ShowCartCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[ShowCartCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    CommonModel *model = self.sectionArray[indexPath.section];
    cell.model = model;
    cell.indexPath = indexPath;
    return cell;
}

//-(UIView *)footerView{
//    UIView *view  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 51)];
//    UIView *lineView  = [[UIView alloc]initWithFrame:CGRectMake(15, 1, kScreenWidth-50, 1)];
//    lineView.backgroundColor = RGB(230, 230, 230);
//    [view addSubview:lineView];
//    return view;
//}
@end
