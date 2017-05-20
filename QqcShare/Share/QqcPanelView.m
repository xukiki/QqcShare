//
//  QqcPanelView.m
//  QqcShareSDK
//
//  Created by qiuqinchuan on 15/3/7.
//  Copyright (c) 2015年 Qqc. All rights reserved.
//

#import "QqcPanelView.h"
#import "QqcPanelItem.h"

#define width_screen  [UIScreen mainScreen].bounds.size.width
#define height_screen [UIScreen mainScreen].bounds.size.height

@implementation QqcPanelView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

//创建界面
- (void)createUI
{
    NSInteger itemCount = [_mArrayItemTitle count];
    //计算item的大小
    CGFloat size_w = (width_screen-_mMarginsHor*2-_mMarginItemHor*(_mColumn-1)) / _mColumn;
    CGFloat size_h = size_w+18.0f;

    for (NSInteger index=0; index<itemCount; ++index)
    {
        //计算item的left_top坐标
        CGFloat x = _mMarginsHor + (index%_mColumn)*(size_w+_mMarginItemHor);
        CGFloat y = (index/_mColumn)*(_mMarginItemVer+size_h);
        
        CGRect rc = CGRectMake(x, y, size_w, size_h);
        UIView* itemView = [[QqcPanelItem alloc] initWithFrame:rc normalImg:_mArrayItemNorImg[index] selImg:_mArrayItemSelImg[index] title:_mArrayItemTitle[index] bundle:_mBundle marginsHor:_mMarginsHor marginsItemHor:_mMarginItemHor clickBlock:^(NSString *title) {
            if ([_delegate respondsToSelector:@selector(onClinkItem:)])
            {
                [_delegate onClinkItem:title];
            }
        }];
        
        [self addSubview:itemView];
    }
}


//根据给定的参数，返回创建的QqcPanelView的高度
- (CGFloat)getHeight
{
    CGFloat height = 0.0f;
    NSInteger itemCount = [_mArrayItemTitle count];
    //计算行数
    NSInteger row = (itemCount%_mColumn!= 0) ? (itemCount/_mColumn +1) : (itemCount/_mColumn);
    //计算item的大小
    CGFloat size_w = (width_screen-_mMarginsHor*2-_mMarginItemHor*(_mColumn-1)) / _mColumn;
    CGFloat size_h = size_w+18.0f;
    
    height = row*size_h + _mMarginItemHor;
    
    return height;
}

@end
