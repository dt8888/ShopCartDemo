//
//  CommonCell.m
//  YJApp
//
//  Created by DT on 2019/5/15.
//  Copyright © 2019年 dayukeji. All rights reserved.
//

#import "CommonCell.h"

@implementation CommonCell
{
     UILabel *_programName;
     UILabel*_saleLabel;
     UILabel *_activictyPrice;
     UILabel*_originPrice;
      UIButton *_activityName;
    UIButton*_lessButton;
    UILabel *_numberLabel;
}
- (void)awakeFromNib {
    [super awakeFromNib];
  
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createView];
    }
    return self;
}
-(void)createView{
    
    
    _programName = [MyUtility createLabelWithFrame:CGRectMake(15, 15,(kScreenWidth-30)/2, 5) title:@"担任自动化设计的更好撒繁花似锦" textColor:RGB(21, 21, 21) font:[UIFont systemFontOfSize:13*kScreenWidth/375] textAlignment:NSTextAlignmentLeft numberOfLines:0];
    _programName.numberOfLines = 0;
    [self.contentView addSubview:_programName];
    
    _saleLabel = [MyUtility createLabelWithFrame:CGRectMake(15, _programName.bottom+18, 100, 13) title:@"已售798" textColor:RGB(153, 153, 153) font:[UIFont systemFontOfSize:12*kScreenWidth/375] textAlignment:NSTextAlignmentLeft numberOfLines:0];
    [self.contentView addSubview:_saleLabel];
    
    _activityName = [MyUtility createButtonWithFrame:CGRectMake(kScreenWidth-85, 90-46, 70, 30) title:@"购买" textColor:[UIColor whiteColor] imageName:@"" target:self action:@selector(btnLessPlusClick:) isCorner:NO isDriction:4];
    _activityName.backgroundColor = VgreenColor;
    _activityName.titleLabel.font = [UIFont systemFontOfSize:12*kScreenWidth/375];
    _activityName.layer.masksToBounds = YES;
     _activityName.tag = 1002;
    _activityName.layer.cornerRadius = 15;
    [self.contentView addSubview:_activityName];
    
    _originPrice = [MyUtility createLabelWithFrame:CGRectMake(_activityName.left-61, 90-38, 50, 13) title:@"¥ 168" textColor:RGB(153, 153, 153) font:[UIFont systemFontOfSize:12*kScreenWidth/375] textAlignment:NSTextAlignmentRight numberOfLines:0];
    [self.contentView addSubview:_originPrice];
    
    _activictyPrice = [MyUtility createLabelWithFrame:CGRectMake(_originPrice.left-50, 90-38, 50, 13) title:@"¥ 168" textColor:RGB(255, 98, 36) font:[UIFont systemFontOfSize:16*kScreenWidth/375] textAlignment:NSTextAlignmentRight numberOfLines:0];
    [self.contentView addSubview:_activictyPrice];
    
    UIImage *plusImage = Image(@"add.png");
    UIButton *plusBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [plusBtn setImage:plusImage forState:UIControlStateNormal];
    plusBtn.frame=CGRectMake(kScreenWidth-plusImage.size.width-15,
                             90-41,
                             plusImage.size.width,
                             plusImage.size.height);
    [plusBtn addTarget:self action:@selector(btnLessPlusClick:) forControlEvents:UIControlEventTouchUpInside];
    plusBtn.tag = 1002;
    _plusButton = plusBtn;
    [plusBtn setHidden:YES];
    //
    UILabel *numberLbl= [MyUtility createLabelWithFrame:CGRectMake(kScreenWidth-64, 90-46, 28, 30) title:@"0" textColor:titleColor font:[UIFont systemFontOfSize:12*kScreenWidth/375] textAlignment:NSTextAlignmentCenter numberOfLines:0];
    [numberLbl setHidden:YES];
    _numberLabel = numberLbl;
    [self.contentView addSubview:numberLbl];
    //
    UIImage *lessImage = Image(@"reduce.png");
    UIButton *lessBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [lessBtn setImage:lessImage forState:UIControlStateNormal];
    lessBtn.frame=plusBtn.frame;
    [lessBtn addTarget:self action:@selector(btnLessPlusClick:) forControlEvents:UIControlEventTouchUpInside];
    lessBtn.tag = 1001;
    lessBtn.alpha = 0;
    _lessButton = lessBtn;
    [self.contentView addSubview:lessBtn];
    [self.contentView addSubview:plusBtn];

}

-(void)setModel:(CommonModel *)model
{
    _model = model;
    _programName.text = model.itemName;
    _saleLabel.text = [NSString stringWithFormat:@"已售%d",model.sales];
    CGSize size = [IHUtility GetSizeByText:model.itemName sizeOfFont:13*kScreenWidth/375 width:(kScreenWidth-30)/2];
    _programName.frame = CGRectMake(15, 15, (kScreenWidth-30)/2, size.height+5);
    _saleLabel.frame = CGRectMake(15, _programName.bottom+18, (kScreenWidth-30)/2, 12);
    _activityName.frame = CGRectMake(kScreenWidth-85, 80-46, 70, 30);
    _plusButton.frame = CGRectMake(kScreenWidth-15-(_plusButton.frame.size.width), 80-41, _plusButton.frame.size.width, _plusButton.frame.size.height);
    _numberLabel.frame =CGRectMake(kScreenWidth-64, 80-46, 28, 30);
    //中划线
    float originalNumber = model.price;
    NSString *originalStr = (originalNumber-((int)originalNumber)>0) ? [[NSString alloc]initWithFormat:@"¥%.1f",originalNumber] : [[NSString alloc]initWithFormat:@"¥%d",(int)originalNumber];
    NSMutableAttributedString *attribtDic = [[NSMutableAttributedString alloc] initWithString:originalStr];
    NSRange strRange = {0,[attribtDic length]};
    CGSize originSize = [IHUtility GetSizeByText:originalStr sizeOfFont:12*kScreenWidth/375 width:100];
    [attribtDic addAttribute:NSForegroundColorAttributeName value:auxiliaryFontColor range:strRange];  //设置颜色
    [attribtDic addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    _originPrice.attributedText = attribtDic;
    _originPrice.frame = CGRectMake(_activityName.left-( originSize.width+20),80-38 , originSize.width+5, 13) ;
    
    //活动价
       float actualNumber = model.rebatePrice;
    NSString*activictyPrice = (actualNumber-((int)actualNumber)>0) ? [[NSString alloc]initWithFormat:@"¥%.1f",actualNumber] : [[NSString alloc]initWithFormat:@"¥%d",(int)actualNumber];
    NSMutableAttributedString *attribt = [[NSMutableAttributedString alloc] initWithString:activictyPrice];
    [attribt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 1)];
    _activictyPrice.attributedText = attribt;
    _activictyPrice.frame = CGRectMake(_originPrice.left-100, [model.cellHight floatValue]-40, 100, 16);
    
    if(model.count>0){
        _numberLabel.text=[[NSString alloc] initWithFormat:@"%d",model.count];
        [_activityName setHidden:YES];
        [_plusButton setHidden:NO];
        [_numberLabel setHidden:NO];
        [_lessButton setFrame:CGRectMake(kScreenWidth-85,
                                              _plusButton.frame.origin.y,
                                              _plusButton.frame.size.width,
                                              _plusButton.frame.size.height)];
        [_lessButton setAlpha:1.0];
    }else{
        [_activityName setHidden:NO];
        [_plusButton setHidden:YES];
        [_numberLabel setHidden:YES];
        _lessButton.frame = _plusButton.frame;
        [_lessButton setAlpha:0];
    }
}

//加入购物车
-(void)btnLessPlusClick:(UIButton*)sender{
    CGFloat price = self.model.rebatePrice;
    bool enter = true;
    NSString *isShowAnimation = @"YES";
    if (sender.tag==1001){ //减 -
        isShowAnimation = @"NO";
        if(self.model.count>0){
            self.model.count -= 1;
            self.isHaveAnimation = NO;
            price = -price;
            _numberLabel.text = [NSString stringWithFormat:@"%d",self.model.count];
            if (self.model.count<=0) {
                [_activityName setHidden:NO];
                [_plusButton setHidden:YES];
                [_numberLabel setHidden:YES];
                [UIView animateWithDuration:0.2 animations:^{
                    [_lessButton setAlpha:0];
                    CGAffineTransform transform = CGAffineTransformRotate(_lessButton.transform, 3.14);
                    [_lessButton setTransform:transform];
                    [_lessButton setFrame:CGRectMake(_plusButton.frame.origin.x,
                                                          _plusButton.frame.origin.y,
                                                          _plusButton.frame.size.width,
                                                          _plusButton.frame.size.height)];
                } completion:^(BOOL finished) {
                    CGAffineTransform transform = CGAffineTransformRotate(_lessButton.transform, 0);
                    [_lessButton setTransform:transform];
                }];
            }
        }else{
            enter = false;
        }
    }else if (sender.tag==1002){ //加 +
        if(self.model.sysl>0 && self.model.count>=self.model.sysl){  //活动剩余数量大于零
//            [WHToast showMessage:@"亲,购买数量不能大于剩余数量哦." duration:1.5 finishHandler:^{
//            }];
            return;
        }
        if (self.model.count==0) {
            [_activityName setHidden:YES];
            [_plusButton setHidden:NO];
            [_numberLabel setHidden:NO];
            [UIView animateWithDuration:0.2 animations:^{
                [_lessButton setAlpha:1.0];
                CGAffineTransform transform = CGAffineTransformRotate(_lessButton.transform, 3.14);
                [_lessButton setTransform:transform];
                [_lessButton setFrame:CGRectMake(kScreenWidth-85,
                                                      _plusButton.frame.origin.y,
                                                      _plusButton.frame.size.width,
                                                      _plusButton.frame.size.height)];
            } completion:^(BOOL finished) {
                CGAffineTransform transform = CGAffineTransformRotate(_lessButton.transform, 0);
                [_lessButton setTransform:transform];
            }];
        }
        self.model.count += 1;
        self.isHaveAnimation = YES;
        _numberLabel.text = [NSString stringWithFormat:@"%d",self.model.count];
    }
    
    NSDictionary *dict = @{@"cell":self,@"index":[NSNumber numberWithInteger:self.indexPath.row],@"num":[NSNumber numberWithInt:self.model.count],@"price":[NSNumber numberWithFloat:price],@"cellModel":self.model,@"isShowAnimation":isShowAnimation};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"addOrReduceProjectNum" object:dict];
}

-(void)setItemNumber:(int)number addToItem:(BOOL)isAddItem
{
    self.model.count = number;
    _numberLabel.text = [NSString stringWithFormat:@"%d",self.model.count];
    if (self.model.count<=0){
        [_activityName setHidden:NO];
        [_plusButton setHidden:YES];
        [_numberLabel setHidden:YES];
        [UIView animateWithDuration:0.2 animations:^{
            [_lessButton setAlpha:0];
            CGAffineTransform transform = CGAffineTransformRotate(_lessButton.transform, 3.14);
            [_lessButton setTransform:transform];
            //            UIImage *lessImage = Image(@"less_item.png");
            [_lessButton setFrame:CGRectMake(_plusButton.frame.origin.x,
                                                  _plusButton.frame.origin.y,
                                                  _plusButton.frame.size.width,
                                                  _plusButton.frame.size.height)];
        } completion:^(BOOL finished) {
            CGAffineTransform transform = CGAffineTransformRotate(_lessButton.transform, 0);
            [_lessButton setTransform:transform];
        }];
    }
    if (isAddItem){
        [_activityName setHidden:YES];
        [_plusButton setHidden:NO];
        [_numberLabel setHidden:NO];
        [UIView animateWithDuration:0.2 animations:^{
            [_lessButton setAlpha:1.0];
            CGAffineTransform transform = CGAffineTransformRotate(_lessButton.transform, 3.14);
            [_lessButton setTransform:transform];
            [_lessButton setFrame:CGRectMake(kScreenWidth-85,
                                                  _plusButton.frame.origin.y,
                                                  _plusButton.frame.size.width,
                                                 _plusButton.frame.size.height)];
        } completion:^(BOOL finished) {
            CGAffineTransform transform = CGAffineTransformRotate(_lessButton.transform, 0);
            [_lessButton setTransform:transform];
        }];
    }
}
@end
