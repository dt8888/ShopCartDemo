//
//  ShopCartView.m
//  YJApp
//
//  Created by DT on 2019/5/14.
//  Copyright © 2019年 dayukeji. All rights reserved.
//

#import "ShopCartView.h"
#import "BadgeView.h"
#import "CommonModel.h"
#import "CommonCell.h"
@implementation ShopCartView
{
    UIView *showView;
    UIView *titleView;
    UILabel *totalPriceLbl;
    UIButton *enterBtn;
    UIView *payView;
    int cellHeight;
    int commTableViewHeight;
    CGFloat totalPrice;
    BadgeView *badge;
    BOOL toShow;
    int storeID;
    int viewPostionY;
    NSString* storeNames;
    
    UIView *redBadge;
    UILabel *num;
    CGFloat hight ;
    UIView *_lineView;
    
}
- (instancetype)initWithFrame:(CGRect)frame
                    attribute:(NSObject *)attribute
                      storeID:(int)storeId
                    storeName:(NSString*)storeName
{
    viewPostionY = frame.origin.y+frame.size.height;
    self = [super initWithFrame:frame];
    if (self) {
        self.attribute = attribute;
        storeID = storeId;
        storeNames = storeName;
         hight = KIsiPhoneX ? 83 : 49;
        [self createView:frame];
    }
    return self;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch  locationInView:self];
    NSLog(@" point   X: %f   Y:%f", point.x, point.y);
    if (point.y<showView.frame.origin.y){
      [self payViewList];
    }
}

-(ShowCartTableView*)tableView
{
    if(!_tableView)
    {
        _tableView = [[ShowCartTableView alloc]initWithFrame:CGRectMake(0, 50, kScreenWidth, 0)];
    }
    return _tableView;
}
-(void)createView:(CGRect)rect
{
    cellHeight = 80;
    totalPrice = 0;
    commTableViewHeight = 0;
    toShow = false;
    [self setBackgroundColor:RGBA(0, 0, 0, 0.5)];
    
    //购物车列表
    showView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-hight, kScreenWidth, hight)];
    [showView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:showView];
    
    UILabel *showText= [MyUtility createLabelWithFrame:CGRectMake(25,25, 125, 16)  title:@"已选商品" textColor:titleColor font:[UIFont systemFontOfSize:15*kScreenWidth/375] textAlignment:NSTextAlignmentLeft numberOfLines:0];
    [showView addSubview:showText];
    
    UIButton *clearBtn = [MyUtility createButtonWithFrame:CGRectMake(kScreenWidth-55, 27, 30, 15) title:@"清空" textColor:titleColor imageName:@"" target:self action:@selector(clearAllClick:) isCorner:NO isDriction:4];
    clearBtn.titleLabel.font = [UIFont systemFontOfSize:12*kScreenWidth/375];
    [showView addSubview:clearBtn];
    [showView addSubview:self.tableView];
    self.tableView.sectionArray = BUYLISTDATA.buyDataArray;
    
    
    payView=[[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-hight, kScreenWidth, hight)];
    payView.backgroundColor=[UIColor whiteColor];
    payView.layer.shadowColor = RGBA(197, 197, 197, 1).CGColor;
    payView.layer.shadowOffset = CGSizeMake(1,2);
    payView.layer.shadowOpacity = 0.8;
    [self addSubview:payView];
    UIImage *gwImage = Image(@"cart");
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10,
                                                              -10,
                                                              gwImage.size.width,
                                                              gwImage.size.height)];
    [_imageView setImage:gwImage];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(payViewList)];
    [payView addGestureRecognizer:tap];
    [payView addSubview:_imageView];;
    
    //购物车上的红点数量
    redBadge = [[UIView alloc]initWithFrame:CGRectMake(_imageView.right-18, 5, 15, 15)];
    redBadge.backgroundColor = [UIColor redColor];
    redBadge.hidden = YES;
    redBadge.layer.cornerRadius = 15 /2;
    redBadge.layer.borderWidth = 1;
    redBadge.layer.borderColor = [UIColor whiteColor].CGColor;
    num = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
    num.font = [UIFont systemFontOfSize:10.0f];
    num.textColor = [UIColor whiteColor];
    num.textAlignment = NSTextAlignmentCenter;
    [redBadge addSubview:num];
    [_imageView addSubview:redBadge];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"去结算" forState:UIControlStateNormal];
    btn.titleLabel.font = sysFont(15);
    btn.backgroundColor = RGB(194, 194,194);
    btn.frame=CGRectMake(kScreenWidth-100, 0, 100, 50);
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(payClick) forControlEvents:UIControlEventTouchUpInside];
    enterBtn = btn;
    [payView addSubview:btn];
    
    UILabel *lbl= [MyUtility createLabelWithFrame:CGRectMake(kScreenWidth-240,0, 125, 50)  title:@"总价格: ¥0" textColor:auxiliaryFontColor font:[UIFont systemFontOfSize:13*kScreenWidth/375] textAlignment:NSTextAlignmentRight numberOfLines:0];
    [payView addSubview:lbl];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:@"总价格: ¥0"];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:RGB(248, 94, 94) range:NSMakeRange(4, 3)];
    totalPriceLbl.attributedText = attributeStr;
    totalPriceLbl = lbl;
    [payView addSubview:lbl];
}

- (void)addDeleteItem:(CGFloat)totalPriceNumber
{
    NSLog(@"%f",totalPriceNumber);
    if ((totalPrice<=0 && totalPriceNumber>0) ||
        (totalPrice>0 && totalPriceNumber<=0))
    {
        if (totalPriceNumber<=0)
        {
            redBadge.hidden = YES;
            enterBtn.backgroundColor = RGB(194, 194,194);
        }else{
            redBadge.hidden = NO;
            enterBtn.backgroundColor = RGB(248, 94, 94);
        }
    }
    totalPrice =totalPriceNumber;
    NSString *textPrice = (totalPriceNumber-((int)totalPriceNumber)>0) ? [[NSString alloc]initWithFormat:@"¥%.1f",totalPriceNumber] : [[NSString alloc]initWithFormat:@"¥%d",(int)totalPriceNumber];
    NSString *titlePrice =[NSString stringWithFormat:@"总价格: %@",textPrice];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:titlePrice];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:RGB(248, 94, 94) range:NSMakeRange(4, titlePrice.length-4)];
    totalPriceLbl.attributedText = attributeStr;
    num.text = [NSString stringWithFormat:@"%d",[self calculationTotalNum]];
    
    commTableViewHeight = [BUYLISTDATA getCount] * cellHeight;
    if (commTableViewHeight>(kScreenHeight-hight)*2/3){
        commTableViewHeight = (kScreenHeight-hight)*2/3;
    }
    self.tableView.frame = CGRectMake(0,50,kScreenWidth,commTableViewHeight);
    [self.tableView reloadData];
    if([BUYLISTDATA getCount]<=0){
        [self clearAllClick:NULL];
    }else
    {
        // 在购物车移除cell
      [self removeOneCell];
   }
}
-(int)calculationTotalNum
{
    int calculationTotalNum = 0;
    for(CommonModel *model in BUYLISTDATA.buyDataArray){
        calculationTotalNum += model.count;
    }
    return calculationTotalNum;
}

-(void)payViewList
{
    [self setBackgroundColor:RGBA(0, 0, 0, 0.5)];
    if (totalPrice <= 0) return;
    UIImage *gwImage = Image(@"cart");
    if(toShow == FALSE){
        self.frame = CGRectMake(0,0,kScreenWidth,viewPostionY);
        payView.frame = CGRectMake(0, self.frame.size.height-50, kScreenWidth, 50);
        showView.frame = CGRectMake(0, self.frame.size.height-50, kScreenWidth, 50);
        _imageView.frame = CGRectMake(10,-10,gwImage.size.width,gwImage.size.height);
    }
    [UIView animateWithDuration:0.3 animations:^{
        if(toShow){
            showView.frame = CGRectMake(0,
                                        viewPostionY-hight,
                                        kScreenWidth,
                                        commTableViewHeight+50);
        } else {
            showView.frame = CGRectMake(0,
                                        viewPostionY-hight-(commTableViewHeight+50),
                                        kScreenWidth,
                                        commTableViewHeight+50);
        }
        
    } completion:^(BOOL finished) {
        if(toShow){
            self.frame = CGRectMake(0,viewPostionY-hight,viewPostionY,hight);
            payView.frame = CGRectMake(0, self.frame.size.height-50, kScreenWidth, 50);
            showView.frame = CGRectMake(0, self.frame.size.height-50, kScreenWidth, 50);
            _imageView.frame = CGRectMake(10,-10,gwImage.size.width,gwImage.size.height);
        }
        toShow = !toShow;
    }];
}

#pragma 清空数据
-(void) clearAllClick:(UIButton*)sender {
    if (sender != NULL){
        for (CommonModel *model in BUYLISTDATA.buyDataArray)
        {
                CommonCell *viewCell = (CommonCell*)model.cell;
                [viewCell setItemNumber:0 addToItem:FALSE];
        }
    }
    totalPrice = 0;
    toShow = FALSE;
    redBadge.hidden = YES;
    num.text = @"";
      enterBtn.backgroundColor = RGB(194, 194,194);
    totalPriceLbl.text = @"总价格:￥0";
    
    [UIView animateWithDuration:0.2 animations:^{
        showView.frame = CGRectMake(0,
                                    viewPostionY-hight,
                                    kScreenWidth,
                                    50);
    } completion:^(BOOL finished) {
        self.frame = CGRectMake(0,viewPostionY-hight,kScreenWidth,50);
        payView.frame = CGRectMake(0, self.frame.size.height-50, kScreenWidth, 50);
        showView.frame = CGRectMake(0, self.frame.size.height-50, kScreenWidth, 50);
        [BUYLISTDATA reset];
        [self.tableView reloadData];
    }];
}

- (void)removeOneCell{
    commTableViewHeight = [BUYLISTDATA getCount] * 80;
    if (commTableViewHeight<(kScreenHeight-hight-50)*2/3){
        [UIView animateWithDuration:0.2 animations:^{
            showView.frame = CGRectMake(0,
                                        viewPostionY-49-(commTableViewHeight+50),
                                        kScreenWidth,
                                        commTableViewHeight+40);
            
            self.tableView.frame = CGRectMake(0,
                                            50,
                                             kScreenWidth,
                                             commTableViewHeight);
        } completion:^(BOOL finished) {
        }];
  }
}
//去结算
-(void)payClick{
    if(self.callBackYJDetailViewController){
        self.callBackYJDetailViewController(totalPrice);
    }
}
@end
