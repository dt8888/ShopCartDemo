//
//  ViewController.m
//  ShopCartDemo
//
//  Created by 董婷 on 2019/5/17.
//  Copyright © 2019年 DT. All rights reserved.
//

#import "ViewController.h"
#import "Contant.h"
#import "CommonModel.h"
#import "CommonCell.h"
#import "ShopCartView.h"
@interface ViewController ()
@property (nonatomic,strong) CALayer *dotLayer;

@property (nonatomic,assign) CGFloat endPointX;

@property (nonatomic,assign) CGFloat endPointY;

@property (nonatomic,strong) UIBezierPath *path;
@property (nonatomic,strong) ShopCartView *shopCartView;
@end

@implementation ViewController

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"addOrReduceProjectNum" object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //监听项目购买数量变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addOrReduceProjectNum:) name:@"addOrReduceProjectNum" object:nil];
    
    NSMutableArray *dataArr = [[NSMutableArray alloc]init];
    CommonModel *model1 = [[CommonModel alloc]init];
    model1.itemName = @"尊品足浴80分钟";
    model1.price = 268;
    model1.rebatePrice = 100;
    
    [dataArr addObject:model1];
    [self.view addSubview:self.tableView];
    self.tableView.sectionArray = dataArr;
    [self.tableView reloadData];
    [self setPayView];
}

-(CommonTableView*)tableView
{
    if(!_tableView)
    {
        _tableView = [[CommonTableView alloc]initWithFrame:CGRectMake(0, 100, kScreenWidth, kScreenHeight)];
    }
    return _tableView;
}

-(void)setPayView{
    CGFloat hight = KIsiPhoneX ? 83 : 49;
    _shopCartView = [[ShopCartView alloc]initWithFrame:CGRectMake(0, kScreenHeight-hight, kScreenWidth, 50)
                                             attribute:self
                                               storeID:44
                                             storeName:@"全国总店"];
    self.delegateShoppingCart = _shopCartView;
    CGRect rect = [self.view convertRect:_shopCartView. imageView.frame fromView:_shopCartView];
    _endPointX = rect.origin.x + 15;
    _endPointY = rect.origin.y + 35;
    [self.view addSubview:_shopCartView];
}
#pragma 监听项目数量变化
-(void)addOrReduceProjectNum:(NSNotification*)notification
{
    NSDictionary *dict = notification.object;
    int number = [dict[@"num"] intValue];
    UITableViewCell *cell = dict[@"cell"];
    NSString* isShowAnimation = dict[@"isShowAnimation"];
    CommonModel *model=dict[@"cellModel"];
    BOOL exist = TRUE;
    for (CommonModel *value in BUYLISTDATA.buyDataArray) {
        if(value.itemId == model.itemId) {
            exist = FALSE;
            if(number<=0) {
                [BUYLISTDATA removeObject:value];
            }else{
                value.count = number;
            }
            break;
        }
    }
    if(exist) {
        model.cell = (CommonCell *) cell;
        [BUYLISTDATA addObject:model];
    }
    if (self.delegateShoppingCart&&[self.delegateShoppingCart respondsToSelector:@selector(addDeleteItem:)]) {
        [self.delegateShoppingCart addDeleteItem:[self calculationTotal]];
    }
    CommonCell *storeCell =  (CommonCell *) model.cell;
    [storeCell setItemNumber:number addToItem:FALSE];
    if([isShowAnimation isEqualToString:@"YES"])
    {
        
        CGRect parentRect = [storeCell convertRect:storeCell.plusButton.frame toView:self.view];
        [self JoinCartAnimationWithRect:parentRect];
    }
}
-(int)calculationTotalNum
{
    int  calculationTotalNum = 0;
    for(CommonModel *model in BUYLISTDATA.buyDataArray){
        calculationTotalNum += model.count;
    }
    return calculationTotalNum;
}

-(CGFloat)calculationTotal
{
    CGFloat totalPriceNumber = 0;
    for(CommonModel *model in BUYLISTDATA.buyDataArray){
        totalPriceNumber += model.rebatePrice*model.count;
    }
    return totalPriceNumber;
}
#pragma mark -加入购物车动画
-(void) JoinCartAnimationWithRect:(CGRect)rect
{
    CGFloat startX = rect.origin.x;
    CGFloat startY = rect.origin.y;
    _path= [UIBezierPath bezierPath];
    [_path moveToPoint:CGPointMake(startX, startY)];
    //三点曲线
    [_path addCurveToPoint:CGPointMake(_endPointX, _endPointY)
             controlPoint1:CGPointMake(startX, startY)
             controlPoint2:CGPointMake(startX - 180, startY - 200)];
    
    _dotLayer = [CALayer layer];
    _dotLayer.backgroundColor = [UIColor redColor].CGColor;
    _dotLayer.frame = CGRectMake(0, 0, 15, 15);
    _dotLayer.cornerRadius = (15 + 15) /4;
    [self.view.layer addSublayer:_dotLayer];
    [self groupAnimation];
    
}
#pragma mark - 组合动画
-(void)groupAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = _path.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"alpha"];
    alphaAnimation.duration = 0.5f;
    alphaAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    alphaAnimation.toValue = [NSNumber numberWithFloat:0.1];
    alphaAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[animation,alphaAnimation];
    groups.duration = 0.5f;
    groups.removedOnCompletion = NO;
    groups.fillMode = kCAFillModeForwards;
    groups.delegate = self;
    [groups setValue:@"groupsAnimation" forKey:@"animationName"];
    [_dotLayer addAnimation:groups forKey:nil];
    
    [self performSelector:@selector(removeFromLayer:) withObject:_dotLayer afterDelay:0.5f];
    
}
- (void)removeFromLayer:(CALayer *)layerAnimation{
    
    [layerAnimation removeFromSuperlayer];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
    if ([[anim valueForKey:@"animationName"]isEqualToString:@"groupsAnimation"]) {
        
        CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        shakeAnimation.duration = 0.25f;
        shakeAnimation.fromValue = [NSNumber numberWithFloat:0.9];
        shakeAnimation.toValue = [NSNumber numberWithFloat:1];
        shakeAnimation.autoreverses = YES;
        [_shopCartView.imageView.layer addAnimation:shakeAnimation forKey:nil];
    }
}
@end
