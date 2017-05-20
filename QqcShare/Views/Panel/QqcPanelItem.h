//
//  QqcPanelItem.h
//  QqcShareSDK
//
//  Created by qiuqinchuan on 15/3/7.
//  Copyright (c) 2015年 Qqc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^blockOnClickBtn)(NSString*);

@interface QqcPanelItem : UIView

- (instancetype)initWithFrame:(CGRect)frame normalImg:(NSString*)strNormalImg selImg:(NSString*)strSelImg title:(NSString*)strTitle bundle:(NSBundle*)bundle_ marginsHor:(NSInteger)hor marginsItemHor:(NSInteger)itemHor clickBlock:(blockOnClickBtn)block;

@end
