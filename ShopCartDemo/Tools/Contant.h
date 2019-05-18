//
//  Contant.h
//  AlphaPorject
//
//  Created by xu bin on 13-8-14.
//  Copyright (c) 2013年 xu bin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^DidSelectheadImageBlock) (NSInteger index);
typedef void (^DidSelectLoginBlock)(NSString *str1,NSString *str2);
typedef void (^DidSelectYZMBlock) (NSString *phone);
typedef void (^DidSelectSurnBlock) (NSString *phone,NSString *code);
typedef void (^DidSelectBtnBlock) (NSInteger index);

typedef enum{
    ENT_City ,   //城市
    ENT_Province,  //省份
}CityType;



typedef enum{
    ENT_BiaoZhu,//标注
    ENT_RenZheng,//认证
    ENT_WanShang,//完善
    ENT_FaBu,//发布
    ENT_DianZan,//点赞
    ENT_pinglun,//评论
    ENT_RenMai,//人脉交互
    
}BtnType;


typedef enum{
    ENT_Lagin ,   //自己
    ENT_Password,  //别人
}LaginType;



typedef enum{
    ENT_register ,   //注册
    ENT_forget,      //找回密码
    ENT_fastest,     //验证码登录
}RegisterType;




typedef enum{
    ENT_price,//单价
     ENT_number,//数量
     ENT_ganJing,//杆径
     ENT_guanFu,//冠幅
     ENT_gaoDu,//高度
    ENT_adress,//分枝点
}ReleaseType;

#define  serStrURL @"https://www.jiaodutong.com/"

#define kScreenHeight [UIScreen mainScreen].bounds.size.height//获取屏幕高度
#define kScreenWidth [UIScreen mainScreen].bounds.size.width//获取屏幕宽度
#define KIsiPhoneX ([UIScreen mainScreen].bounds.size.height>800.0f)
#define  tabBarHeigh    ([UIScreen mainScreen].bounds.size.height>800.0f) ? 83:49
#define  navHeigh     ([UIScreen mainScreen].bounds.size.height>800.0f) ? 88:64

#define ALIpayment  @"ALI_APP"
#define WXpayment  @"WX_APP"
//通知宏
#define NotificationMall         @"NotificationMall"
#define NotificationLoginIn         @"NotificationLoginIn"
#define NotificationOutLogin        @"NotificationOutLogin"
#define  NotificationTabBarOrderHiddenRedPoint      @"NotificationTabBarOrderHiddenRedPoint" //是否订单隐藏红点
#define  NotificationTabBarHiddenRedPoint      @"NotificationTabBarHiddenRedPoint" //是否隐藏红点
#define NotificationAddSupplyBuyTopic      @"NotificationAddSupplyBuyTopic" //新增供应、求购、话题
#define NotificationChangeTabBarSelectedIndex       @"NotificationChangeTabBarSelectedIndex"//切换tabbar
#define NotificationMallBack       @"NotificationMallBack"//返回
#define setBackMainPage       @"setBackMainPage"//返回首页
#define NotificationUpdateUserinfo  @"NotificationUpdateUserinfo"//更新用户信息
#define NotificationRefeshInit    @"NotificationRefeshInit" //更新初始化 //保证每天更新一次
#define NotificationChooseCity    @"NotificationChooseCity"//选择城市
#define NotificationAgree         @"NotificationAgree"//点赞

#define NotificationloginInfo           @"NotificationloginInfo"  //挤登录

#define NotificationCommentMe   @"NotificationCommentMe"  //评论我的

#define  pageNum      10
#define  headerHight      50

#define RGBHex(s)                [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:1.0]
#define RGBA(r,g,b,a)			  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]


#define sysFont(f) [UIFont systemFontOfSize:f]
#define boldFont(f) [UIFont boldSystemFontOfSize:f]

#define kContactType            @"kContactType"


#define  Image(png) [UIImage imageNamed:png]
#define defalutHeadImage                [UIImage imageNamed:@"defaulthead.png"]

#define DefaultImage                   [UIImage imageNamed:@"object_default.png"]


#define titleFont   14*kScreenWidth/375
#define infoFont   13*kScreenWidth/375
#define textFont   11*kScreenWidth/375
#define navTitleFont   16*kScreenWidth/375

#define kCalloutViewMargin          -8

#define   titleColor   RGB(51, 51, 51)
#define   textCol  RGB(102, 102, 102)
#define  cBgColor     RGB(233,239,239)   //背景色
#define  cBlackColor  RGB(108,123,138)   //深黑色
#define  cLineColor   RGBA(189,202,218,0.3)   //线得色值
#define  cGrayLightColor    RGBA(189,202,218,1)   //浅灰色字体
#define  VgreenColor  RGB(15,205,176)   //绿色
#define windowColor  [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]
//16位颜色
#define HEXColor(hexValue,alphaValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:alphaValue]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]


#define Upload_url_write            @"https://yijiao.oss-cn-qingdao.aliyuncs.com/"
#define Upload_url_compress_write   @"https://yijiao.img-cn-qingdao.aliyuncs.com/"
#define stringFormatInt(n) [NSString stringWithFormat:@"%d",n]
#define stringFormatString(n)  [NSString stringWithFormat:@"%@",n]
#define stringFormatDouble(n)  [NSString stringWithFormat:@"%f",n]

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define  ITEMWCell (WindowWith-2)/2.0

#define RGBA(r,g,b,a)                            [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RGB(r,g,b)      [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0f]
//16位颜色
#define HEXColor(hexValue,alphaValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:alphaValue]
//2016.8 zhou
#define visualReinforcementColor  RGB(85, 202, 170)     //主体视觉色.
#define lightThemeColor          RGB(61, 179, 243)     //视觉强化色. 惠
#define visualThemeColor          RGB(85, 202, 170)     //视觉强化色.
#define  colorTe                  RGB(80, 227, 194)     //绿色 特
#define auxiliaryFontColor        RGB(162, 162, 162)    //辅助字体颜色
#define deputyMainPageColor       RGB(240, 240, 240)    //辅助页面颜色
#define decorativeColors          RGB(225, 169, 0)      //点缀色 黄色   促
#define remindColors              RGB(222, 124, 111)    //提醒色 红色
#define redColors                 RGB(255, 90,90)    //拼 红色
#define buttonTitleDownColors     RGB(197, 197, 197)    //按钮按住时的响应色(数字的颜色)
#define buttonDownColors          RGB(68, 164, 138)     //按钮按住时的响应色(绿色按钮的背景色)
#define buttonDownYellowColors          RGB(224, 141, 7)     //按钮按住时的响应色(黄色按钮的背景色)

#define kBoutiqueStoresList               @"kBoutiqueStoresList"   //精选门店列表
#define kHistoricalSearchList             @"kHistoricalSearchList" //历史搜索列表
#define kMyNewsIsRead                     @"kMyNewsIsRead"         //我的消息是否查看
#define kDeleteCollectionCell             @"kDeleteCollectionCell"
#define kRegisterPushMessage              @"kRegisterPushMessage"   //推送消息

#define  storeNameColor  HEXColor(0x333333,1)
#define distanceColor  visualThemeColor
#define timeBusinss  HEXColor(0x666666,1)
#define  startColor   HEXColor(0x999999,1)

#define storeNameFont  16*kScreenWidth/375
#define distanceFont   12*kScreenWidth/375
#define adressFont  12*kScreenWidth/375
#define buyFont  14*kScreenWidth/375


#define mineTextFontColor        RGB(70, 73, 82)    //辅助字体颜色
typedef enum{
    ENT_ReviewAll,            //全部
    ENT_ReviewVerySatisfied,  //很满意
    ENT_ReviewSatisfied,      //满意
    ENT_ReviewCommonly,       //一般
}ReviewType;

//项目类别ID 1-足浴类；2-按摩类；3-中医类；4-SPA；5-汗蒸；7-商品
typedef enum{
    ENT_FootBath=1,//足浴
    ENT_ChineseMedicine=3,//中医
    ENT_Thai=2,//泰式
    ENT_SPA=4,//SPA
    ENT_Steam=5,//汗蒸
}BathProject;

typedef enum{
    ENT_NamePassLogin,      //用户密码登录
    ENT_FastestLogin,       //验证码登录
}LoginType;

typedef enum{
    ENT_ItemPlaceOrder,                     //项目下单
    ENT_groupFightItemPlaceOrder,   //拼团下单
    ENT_MakeAnAppointmentPlaceOrder,        //预约下单
}PlaceOrderType;

//typedef enum{
//    ENT_PendingPaymentToPay,                     //我的页待付款去支付
//    ENT_CollectToPay,                            //我的页收藏去下单支付
//}MeMainVCToPayType;

typedef enum{
    ENT_HomePageViewController,             //首页下单(秒杀、首页门店、首页预约技师)
    ENT_YiJiaoMainViewController,           //精选页下单(精选、猜你喜欢)
    ENT_MeMainViewController,               //我的页下单(待付款、收藏)
     ENT_OrderViewController,               //订单页(待付款、收藏)
    ENT_GroupDetailViewController,               //拼团详情
     ENT_GroupFightViewController,               //拼团专区(待付款、收藏)
    ENT_SpecialZoonViewController,               //下午场，晚晚场
    ENT_NoneVC,
}OrderViewControllerType;

typedef enum{
    ENT_MeMainController,             //我的页面进入拼团
    ENT_StoreItemsController,           //项目进入拼团
    ENT_MyGroupController,           //我的拼团进入拼团
    ENT_YiJiaoMainController,  //点技师
     ENT_ShowPhotoController,  //预览
}ViewControllerType;

typedef enum{
//    state:订单状态 0-待付款 1-待使用 2-待评价 3-已退款  4-已使用
    ENT_PendingPayment=0,//待付款
    ENT_ToBeUsed=1,//待使用
    ENT_ToBeEvaluated=2,//待评价
    ENT_AftermarketRefund=3,//售后/退款
    ENT_AlreadyUsed=4,//已使用
    ENT_NewOrder=5,//最近地单
}OrderInfoList;

typedef enum{
    ENT_Store,//收藏商家
    ENT_Item,//收藏项目
    ENT_Information,//收藏治未病
}CollectType;

typedef enum{
    ENT_FindGoodStore,//发现好店
    ENT_RecommendableProject,//特色项目
}DiscoveryModuleType;

//BC_TRANSFER:企业打款
//ALI_TRANSFER:支付宝企业打款
//WX_TRANSFER:微信企业打款
//WX_REDPACK:微信红包

typedef enum{
    //    state:企业打款  1-银行卡 2-微信 3-支付宝  4-微信红包
    BC_TRANSFER,
    WX_TRANSFER,
    ALI_TRANSFER,
    WX_REDPACK,
}CashMoney;

//typedef enum{  //0-谈症状 1-论养生 2-食疗
//    ENT_TheDoctorAsked=0,    //谈症状
//    ENT_HealthTalk=1,        //论养生
//    ENT_WholenessOfBody=2,   //食疗
//}CureDiseaseType;


//微信数据
static NSString *kAuthScope = @"snsapi_message,snsapi_userinfo,snsapi_friend,snsapi_contact";
static NSString *kAuthOpenID = @"wx8cbe0893d79e725a";
static NSString *kAuthState = @"wechat_sdk_yijiao_zuyu";
//腾讯数据
static NSString *kTencentAppID = @"1105726837";
static NSString *kTencentAppKey = @"k9O1EmoNL9lkAA13";

//App Store 的APP ID
static NSString *kAppID = @"1179914910";

#pragma mark  经纬度转换
static const double x_pi = 3.14159265358979324 * 3000.0 / 180.0;






