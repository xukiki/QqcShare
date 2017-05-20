//
//  QqcShareView.h
//  QqcShareSDK
//
//  Created by qiuqinchuan on 15-4-17.
//  Copyright (c) 2015年 Qqc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QqcPlatformDef.h"


typedef void(^BlockDidSelPlatformType)(QqcSharePlatformType platformType);

@interface QqcShareView : UIView

@property (nonatomic, copy) NSString* strOrientation;
@property (nonatomic, copy) BlockDidSelPlatformType blockSel;

/**
 *  默认初始化
 *
 *  @return 对象
 */
-(instancetype) init;

/**
 *  带设置显示列的初始化
 *
 *  @param col 显示的列数
 *
 *  @return 实体类
 */
- (instancetype)initWithColumn:(NSInteger)col;

/**
 *  显示分享菜单界面
 *
 *  @param platformType 分享类型回调block
 */
-(void) show:(BlockDidSelPlatformType)platformType;

@end