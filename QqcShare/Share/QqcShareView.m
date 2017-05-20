//
//  QqcShareView.m
//  QqcShareSDK
//
//  Created by qiuqinchuan on 15-4-17.
//  Copyright (c) 2015年 Qqc. All rights reserved.
//

#import "QqcShareView.h"
#import "QqcPanelView.h"
#import "QqcIncludeShareSdk.h"

#define border_sharebutton width_screen/4
#define tag_Qqcshareviewbutton 10

#define width_screen  [UIScreen mainScreen].bounds.size.width
#define height_screen [UIScreen mainScreen].bounds.size.height

#define array_sharetitles @[@"QQ好友",@"QQ空间",@"新浪微博",@"微信好友",@"微信朋友圈",@"二维码"]
#define array_shareimages @[@"icon_fenxiang_qqhaoyou.png",@"icon_fenxiang_qqkongjian.png",@"icon_fenxiang_xinlangweibo.png",@"icon_fenxiang_weixinhaoyou.png",@"icon_fenxiang_weixinpengyouquan.png",@"icon_fenxiang_erweima.png"]
#define array_shareimages_ipad @[@"icon_share_qq_ipad",@"icon_share_qqzone_ipad",@"icon_share_sinaweibo_ipad",@"icon_share_weixin_ipad",@"icon_share_weixintime_ipad",@"icon_share_qrcode_ipad"]


#define color_from_rgb(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define color_929292 color_from_rgb(0x929292)

@interface QqcShareView()<QqcPanelViewDelegate>

@property(nonatomic, strong)UIView* toolView;
@property(nonatomic, assign)NSInteger column;
@property(nonatomic, assign)CGFloat toolViewHeight;

@property(nonatomic, strong)NSMutableArray* arrayShareTitle;
@property(nonatomic, strong)NSMutableArray* arrayShareNorImgs;
@property(nonatomic, strong)NSMutableArray* arrayShareSelImgs;

@end

@implementation QqcShareView

#pragma 初始化
- (NSMutableArray *)arrayShareTitle
{
    if (nil == _arrayShareTitle) {
        _arrayShareTitle = [[NSMutableArray alloc] initWithCapacity:0];
    }
    else{
        [_arrayShareTitle removeAllObjects];
    }
    
    //if ([WXApi isWXAppInstalled])
    {
        [_arrayShareTitle addObject:@"微信好友"];
        [_arrayShareTitle addObject:@"朋友圈"];
    }
    
    //if ([QQApiInterface isQQInstalled])
    {
        [_arrayShareTitle addObject:@"QQ好友"];
        [_arrayShareTitle addObject:@"QQ空间"];
    }
    
//    if ([WeiboSDK isWeiboAppInstalled])
//    {
//        [_arrayShareTitle addObject:@"新浪微博"];
//    }
//    
//    [_arrayShareTitle addObject:@"短信"];
//    [_arrayShareTitle addObject:@"复制链接"];
    
    return _arrayShareTitle;
}

- (NSMutableArray *)arrayShareNorImgs
{
    if (nil == _arrayShareNorImgs) {
        _arrayShareNorImgs = [[NSMutableArray alloc] initWithCapacity:0];
    }
    else{
        [_arrayShareNorImgs removeAllObjects];
    }
    
    //if ([WXApi isWXAppInstalled])
    {
        [_arrayShareNorImgs addObject:@"icon_fenxiang_weixinhaoyou.png"];
        [_arrayShareNorImgs addObject:@"icon_fenxiang_weixinpengyouquan.png"];
    }
    
   //if ([QQApiInterface isQQInstalled])
    {
        [_arrayShareNorImgs addObject:@"icon_fenxiang_qqhaoyou.png"];
        [_arrayShareNorImgs addObject:@"icon_fenxiang_qqkongjian.png"];
    }
    
//    if ([WeiboSDK isWeiboAppInstalled])
//    {
//        [_arrayShareNorImgs addObject:@"icon_fenxiang_xinlangweibo.png"];
//    }
    
//    [_arrayShareNorImgs addObject:@"icon_fenxiang_msg.png"];
//    
//    [_arrayShareNorImgs addObject:@"icon_fenxiang_copy.png"];
//    
    return _arrayShareNorImgs;
}

- (NSMutableArray *)arrayShareSelImgs
{
    if (nil == _arrayShareSelImgs) {
        _arrayShareSelImgs = [[NSMutableArray alloc] initWithCapacity:0];
    }
    else
    {
        [_arrayShareSelImgs removeAllObjects];
    }
    
    //if ([WXApi isWXAppInstalled])
    {
        [_arrayShareSelImgs addObject:@"icon_fenxiang_weixinhaoyou.png"];
        [_arrayShareSelImgs addObject:@"icon_fenxiang_weixinpengyouquan.png"];
    }
    
    if ([QQApiInterface isQQInstalled])
    {
        [_arrayShareSelImgs addObject:@"icon_fenxiang_qqhaoyou.png"];
        [_arrayShareSelImgs addObject:@"icon_fenxiang_qqkongjian.png"];
    }
    
    if ([WeiboSDK isWeiboAppInstalled])
    {
        [_arrayShareSelImgs addObject:@"icon_fenxiang_xinlangweibo.png"];
    }
    
    [_arrayShareSelImgs addObject:@"icon_fenxiang_msg.png"];
    
    [_arrayShareSelImgs addObject:@"icon_fenxiang_copy.png"];
    
    return _arrayShareSelImgs;
}

#pragma 接口
-(instancetype) init
{
    self = [self initWithColumn:4];
    if (self) {
        ;
    }
    
    return self;
}

- (instancetype)initWithColumn:(NSInteger)col
{
    self = [super initWithFrame:CGRectMake(0, 0, width_screen, height_screen)];
    
    if (self)
    {
        _column = col;
        
        [self createUI];
    }
    
    return self;
}


-(void)show:(BlockDidSelPlatformType)platformType
{
    _blockSel = platformType;
    [self addSubview:_toolView];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.33 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        self.alpha = 1.0;
        _toolView.frame = CGRectMake(0, height_screen - _toolViewHeight, width_screen, _toolViewHeight);
        
    } completion:^(BOOL finished) {
        ;
    }];
}

#pragma mark - 业务逻辑
-(void) dismiss
{
    [UIView animateWithDuration:0.33 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        self.alpha = 0.0;
        _toolView.frame = CGRectMake(0, height_screen, width_screen, _toolViewHeight);
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
    CGPoint point = [touch locationInView:self]; //返回触摸点在视图中的当前坐标
    int x = point.x;
    int y = point.y;
    NSLog(@"touch (x, y) is (%d, %d)", x, y);
    
    if (CGRectContainsPoint([_toolView frame], point)) {
    }else{
        
        _blockSel(QqcSharePlatformTypeUnknown);
        [self dismiss];
    }
}

#pragma mark - 创建界面元素
- (void)createUI
{
    NSString* strPath = [[NSBundle mainBundle] pathForResource:@"QqcShare" ofType:@"bundle"];
    NSBundle* bundle = nil;
    if (strPath)
    {
        bundle = [NSBundle bundleWithPath:strPath];
    }
    
    self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.6];
    
    _toolView = [[UIView alloc] initWithFrame:CGRectZero];
    _toolView.backgroundColor = [UIColor whiteColor];
    
    //标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 16, width_screen-32, 22)];
    titleLabel.text = @"分享到";
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:18];
    
    [_toolView addSubview:titleLabel];
    
    //分享功能按钮视图
    QqcPanelView* itemView = [[QqcPanelView alloc] initWithFrame:CGRectZero];
    itemView.delegate = self;
    itemView.mBundle = bundle;
    itemView.mColumn = _column;
    itemView.mMarginItemHor = 24.0f;
    itemView.mMarginItemVer = 20.0f;
    itemView.mMarginsHor = 12.0f;
    itemView.mArrayItemTitle = self.arrayShareTitle;
    itemView.mArrayItemNorImg = self.arrayShareNorImgs;
    itemView.mArrayItemSelImg = self.arrayShareSelImgs;
    [itemView createUI];
    CGFloat itemViewHeight = [itemView getHeight];
    itemView.frame = CGRectMake(0, CGRectGetMaxY(titleLabel.frame)+16, width_screen, itemViewHeight);
    [_toolView addSubview:itemView];
    
    //调整toolView的高度
    _toolViewHeight = itemViewHeight + 22 + 16 + 16 + 20;
    _toolView.frame = CGRectMake(0, height_screen, width_screen, _toolViewHeight);
    [self addSubview:_toolView];
}

#pragma mark - 响应函数
- (void)onClinkItem:(NSString*)strTitle
{
    QqcSharePlatformType platformType = QqcSharePlatformTypeQQFriend;
    
    if ([strTitle isEqualToString:@"QQ好友"])
    {
        platformType = QqcSharePlatformTypeQQFriend;
    }
    else if ([strTitle isEqualToString:@"QQ空间"])
    {
        platformType = QqcSharePlatformTypeQQZone;
    }
    else if ([strTitle isEqualToString:@"新浪微博"])
    {
        platformType = QqcSharePlatformTypeSinaWeibo;
    }
    else if ([strTitle isEqualToString:@"微信好友"])
    {
        platformType = QqcSharePlatformTypeWeixinSession;
    }
    else if ([strTitle isEqualToString:@"朋友圈"])
    {
        platformType = QqcSharePlatformTypeWeixinTimeline;
    }
    else if ([strTitle isEqualToString:@"短信"])
    {
        platformType = QqcSharePlatformTypeMsg;
    }
    else if ([strTitle isEqualToString:@"复制链接"])
    {
        platformType = QqcSharePlatformTypeCopy;
    }
    
    _blockSel(platformType);
    
    [self dismiss];
}

@end
