//
//  ShowCartCell.m
//  YJApp
//
//  Created by DT on 2019/5/16.
//  Copyright © 2019年 dayukeji. All rights reserved.
//

#import "ShowCartCell.h"

@implementation ShowCartCell
{
    UILabel *_programName;
    UILabel*_saleLabel;
    UILabel *_activictyPrice;
    UILabel*_originPrice;
    UIButton *_activityName;
    UIButton*_lessButton;
    UILabel *_numberLabel;
    UIButton* _plusButton;
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
    _programName = [MyUtility createLabelWithFrame:CGRectMake(15, 15,kScreenWidth-30, 15) title:@"" textColor:RGB(21, 21, 21) font:[UIFont systemFontOfSize:13*kScreenWidth/375] textAlignment:NSTextAlignmentLeft numberOfLines:0];
    _programName.numberOfLines = 0;
    [self.contentView addSubview:_programName];
    
    _activictyPrice = [MyUtility createLabelWithFrame:CGRectMake(15, _programName.bottom+16, 50, 13) title:@"" textColor:RGB(255, 98, 36) font:[UIFont systemFontOfSize:16*kScreenWidth/375] textAlignment:NSTextAlignmentLeft numberOfLines:0];
    [self.contentView addSubview:_activictyPrice];
    
    _originPrice = [MyUtility createLabelWithFrame:CGRectMake(15, _programName.bottom+16, 50, 13) title:@"" textColor:RGB(153, 153, 153) font:[UIFont systemFontOfSize:12*kScreenWidth/375] textAlignment:NSTextAlignmentLeft numberOfLines:0];
    [self.contentView addSubview:_originPrice];
    
    UIImage *plusImage = Image(@"add.png");
    UIButton *plusBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [plusBtn setImage:plusImage forState:UIControlStateNormal];
    plusBtn.frame=CGRectMake(kScreenWidth-plusImage.size.width-15,
                             80-45,
                             plusImage.size.width,
                             plusImage.size.height);
    [plusBtn addTarget:self action:@selector(btnLessPlusClick:) forControlEvents:UIControlEventTouchUpInside];
    plusBtn.tag = 1002;
    _plusButton = plusBtn;
    //
    UILabel *numberLbl= [MyUtility createLabelWithFrame:CGRectMake(kScreenWidth-64, 80-45, 28, plusImage.size.height) title:@"1" textColor:titleColor font:[UIFont systemFontOfSize:12*kScreenWidth/375] textAlignment:NSTextAlignmentCenter numberOfLines:0];
    _numberLabel = numberLbl;
    [self.contentView addSubview:numberLbl];
    //
    UIImage *lessImage = Image(@"reduce.png");
    UIButton *lessBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [lessBtn setImage:lessImage forState:UIControlStateNormal];
    lessBtn.frame=CGRectMake(kScreenWidth-85,
                             80-45,
                             plusImage.size.width,
                             plusImage.size.height);;
    [lessBtn addTarget:self action:@selector(btnLessPlusClick:) forControlEvents:UIControlEventTouchUpInside];
    lessBtn.tag = 1001;
    _lessButton = lessBtn;
    [self.contentView addSubview:lessBtn];
    [self.contentView addSubview:plusBtn];
    
}

-(void)btnLessPlusClick:(UIButton*)sender{
   CGFloat price = self.model.yjPrice;
    bool enter = true;
    if (sender.tag==1001){
        if(self.model.count>0){
            self.model.count -= 1;
            price = -price;
            _numberLabel.text = [NSString stringWithFormat:@"%d",self.model.count];
            if (self.model.count<=0) {
                [_numberLabel setHidden:YES];
                [UIView animateWithDuration:0.2 animations:^{
                    [_lessButton setAlpha:0];
                    CGAffineTransform transform = CGAffineTransformRotate(_lessButton.transform, 3.14);
                    [_lessButton setTransform:transform];
                    [_lessButton setFrame:CGRectMake(kScreenWidth-85,
                                                     _plusButton.frame.origin.y,
                                                 _plusButton.frame.size.width,
                                                 _plusButton.frame.size.height)];
                } completion:^(BOOL finished) {
                    [_numberLabel setHidden:NO];
                    [_lessButton setAlpha:1.0];
                    [_lessButton setFrame:CGRectMake(kScreenWidth-85,
                                                 _plusButton.frame.origin.y,
                                                 _plusButton.frame.size.width,
                                                 _plusButton.frame.size.height)];
                    CGAffineTransform transform = CGAffineTransformRotate(_lessButton.transform, 0);
                    [_lessButton setTransform:transform];
                }];
            }
        }else{
            enter = false;
        }
    }else if (sender.tag==1002){
        if(self.model.sysl>0 && self.model.count>=self.model.sysl){  //活动剩余数量大于零
//            [IHUtility removeWaitingView];
//            [WHToast showMessage:@"亲,购买数量不能大于剩余数量哦." duration:1.5 finishHandler:^{
//            }];
            return;
        }
        
        if (self.model.count==0) {
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
        _numberLabel.text = [NSString stringWithFormat:@"%d",self.model.count];
    }
    NSDictionary *dict = @{@"cell":self,@"index":[NSNumber numberWithInteger:self.indexPath.section],@"num":[NSNumber numberWithInt:self.model.count],@"price":[NSNumber numberWithFloat:price],@"cellModel":self.model,@"isShowAnimation":@"NO"};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"addOrReduceProjectNum" object:dict];
}

-(void)setModel:(CommonModel *)model
{
    _model = model;
    _programName.text = model.itemName;
    _numberLabel.text = [[NSString alloc]initWithFormat:@"%d",model.count];
    //活动价
    float actualNumber = model.rebatePrice;
    NSString*activictyPrice = (actualNumber-((int)actualNumber)>0) ? [[NSString alloc]initWithFormat:@"¥%.1f",actualNumber] : [[NSString alloc]initWithFormat:@"¥%d",(int)actualNumber];
    NSMutableAttributedString *attribt = [[NSMutableAttributedString alloc] initWithString:activictyPrice];
    [attribt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12*kScreenWidth/375] range:NSMakeRange(0, 1)];
    _activictyPrice.attributedText = attribt;
     CGSize originSize = [IHUtility GetSizeByText:activictyPrice sizeOfFont:16*kScreenWidth/375 width:120];
    _activictyPrice.frame = CGRectMake(15, _programName.bottom+13, originSize.width+5, 30);
    
    //中划线
    float originalNumber = model.price;
    NSString *originalStr = (originalNumber-((int)originalNumber)>0) ? [[NSString alloc]initWithFormat:@"¥%.1f",originalNumber] : [[NSString alloc]initWithFormat:@"¥%d",(int)originalNumber];
    NSMutableAttributedString *attribtDic = [[NSMutableAttributedString alloc] initWithString:originalStr];
    NSRange strRange = {0,[attribtDic length]};
    [attribtDic addAttribute:NSForegroundColorAttributeName value:auxiliaryFontColor range:strRange];  //设置颜色
    [attribtDic addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    _originPrice.attributedText = attribtDic;
    _originPrice.frame = CGRectMake(_activictyPrice.right, _programName.bottom+20 , 100, 13) ;
    
}



@end
