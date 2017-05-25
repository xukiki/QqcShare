//
//  QqcQRCodeView.m
//  QqcShareSDK
//
//  Created by qiuqinchuan on 15/9/28.
//  Copyright © 2015年 Qqc. All rights reserved.
//

#import "QqcQRCodeView.h"

#define width_screen  [UIScreen mainScreen].bounds.size.width
#define height_screen [UIScreen mainScreen].bounds.size.height

@implementation QqcQRCodeView

-(id) initWithImage:(UIImage *)image{
    self = [super initWithFrame:CGRectMake(0, 0, width_screen, height_screen)];
    
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.6];
        
        CGFloat width = 230;
        
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 268)];
        contentView.center = self.center;
        contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:contentView];
        
        //[QqcUtilityUI drawLine:contentView rect:CGRectMake(0, 36, width, 0) color:color_dedede];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 35)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.text =  @"扫码分享";
        titleLabel.font = [UIFont systemFontOfSize:14];
        [contentView addSubview:titleLabel];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake((width - 182)/2, 36 + 12, 182, 182);
        [contentView addSubview:imageView];
        
        UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame), width, 36)];
        tipLabel.text = @"邀好友扫一扫分享给TA";
        tipLabel.font = [UIFont systemFontOfSize:14];
        tipLabel.textColor = [UIColor grayColor];
        tipLabel.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:tipLabel];
        
        UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(width - 36, 0, 36, 36)];
        [closeButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        
        NSString* strPath = [[NSBundle mainBundle] pathForResource:@"QqcShare" ofType:@"bundle"];
        NSBundle* bundle = [[NSBundle alloc] initWithPath:strPath];
        [closeButton setImage:[self getImgFromBundle:bundle img:@"icon_close_gray.png"] forState:UIControlStateNormal];
        [contentView addSubview:closeButton];
    }
    
    return self;
}

-(void) show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
}

-(void) dismiss
{
    [self removeFromSuperview];
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
@end
