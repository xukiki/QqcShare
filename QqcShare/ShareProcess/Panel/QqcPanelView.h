//
//  QqcPanelView.h
//  QqcShareSDK
//
//  Created by qiuqinchuan on 15/3/7.
//  Copyright (c) 2015年 Qqc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QqcPanelViewDelegate <NSObject>

@optional
- (void)onClinkItem:(NSString*)strTitle;

@end

@interface QqcPanelView : UIView

@property(nonatomic,assign) NSInteger   mColumn;                //一行最大的列数
@property(nonatomic,assign) CGFloat     mMarginsHor;            //左右边距
@property(nonatomic,assign) CGFloat     mMarginItemVer;         //子节点间的上下间隔
@property(nonatomic,assign) CGFloat     mMarginItemHor;         //子节点间的左右间隔
@property(nonatomic,strong) NSBundle*   mBundle;                //资源目录

@property(nonatomic,strong) NSArray*    mArrayItemSelImg;       //子节点选中图标队列
@property(nonatomic,strong) NSArray*    mArrayItemNorImg;       //子节点正常图标队列
@property(nonatomic,strong) NSArray*    mArrayItemTitle;        //子节点标题队列

@property(nonatomic,weak) id<QqcPanelViewDelegate> delegate;   //代理

- (instancetype)initWithFrame:(CGRect)frame;

//创建界面
- (void)createUI;

//根据给定的参数，返回创建的QqcPanelView的高度
- (CGFloat)getHeight;

@end
