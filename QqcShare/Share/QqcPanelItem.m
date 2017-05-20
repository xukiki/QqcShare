//
//  QqcPanelItem.m
//  QqcShareSDK
//
//  Created by qiuqinchuan on 15/3/7.
//  Copyright (c) 2015年 Qqc. All rights reserved.
//

#import "QqcPanelItem.h"

@interface QqcPanelItem()

@property (nonatomic, copy) blockOnClickBtn blockClick;
@property (nonatomic, copy) NSString* strTitle;

@end

@implementation QqcPanelItem

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame normalImg:(NSString*)strNormalImg selImg:(NSString*)strSelImg title:(NSString*)strTitle bundle:(NSBundle*)bundle_ marginsHor:(NSInteger)hor marginsItemHor:(NSInteger)itemHor clickBlock:(blockOnClickBtn)block
{
    _blockClick = block;
    _strTitle = strTitle;
    self = [super initWithFrame:frame];
    CGFloat margin = MIN(hor, itemHor);
    
    if (self)
    {
        UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.width)];
        [btn setImage:[self getImgFromBundle:bundle_ img:strNormalImg] forState:UIControlStateNormal];
        [btn setImage:[self getImgFromBundle:bundle_ img:strSelImg] forState:UIControlStateSelected];
        
        [btn addTarget:self action:@selector(onBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
        
        UILabel* lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(-margin, CGRectGetMaxY(btn.frame), frame.size.width+2*margin, 18)];
        lblTitle.text = strTitle;
        lblTitle.textAlignment = NSTextAlignmentCenter;
        lblTitle.font = [UIFont systemFontOfSize:13.0f];
        lblTitle.textColor = [UIColor grayColor];
        
        [self addSubview:lblTitle];
    }
    
    return self;
}

- (UIImage*)getImgFromBundle:(NSBundle*)bundle_ img:(NSString*)strImg
{
    NSBundle* bundle = bundle_ ? bundle_ : [NSBundle mainBundle];
    NSString* strName;
    NSString* strType;
    
    NSArray* arrayNor = [strImg componentsSeparatedByString:@"."];//这里以strNormalImg中只有一个.来简单处理
    if (2 == [arrayNor count])
    {
        NSRange rang = [strImg rangeOfString:@"." options:NSBackwardsSearch];
        if (rang.length > 0)
        {
            strName = [strImg substringToIndex:rang.location];
            
            if ([UIScreen mainScreen].scale == 2) {
                strName = [strName stringByAppendingString:@"@2x"];
            }
            else if([UIScreen mainScreen].scale == 3)
            {
                strName = [strName stringByAppendingString:@"@3x"];
            }
            
            strType = [strImg substringFromIndex:rang.location+1];
        }
        else
        {
            strName = strImg;
            strType = @"png";
        }
    }
    
    NSString* strImgPath = [bundle pathForResource:strName ofType:strType];
    return [UIImage imageWithContentsOfFile:strImgPath];
}

- (void)onBtnClick:(UIButton*)sender
{
    _blockClick(_strTitle);
}

@end
