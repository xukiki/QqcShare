//
//  QqcShareProcess.h
//  QqcShareSDK
//
//  功能：第三方分享类
//
//  Created by qiuqinchuan on 15/2/13.
//  Copyright (c) 2015年 Qqc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QqcPlatformDef.h"
#import "QqcShareView.h"


@interface ShareProcess : NSObject

typedef void(^QqcShareHandler)(QqcShareStatusType state, UIImage *image);

//把分享结果给调用者处理
+ (void)shareWithPlatformType:(QqcSharePlatformType)platformType contentType:(QqcShareContentType)contentType title:(NSString *)strTitle content:(NSString *)strContent url:(NSString *)strUrl musicFileURL:(NSString*)strMusicFileURL image:(NSString *)strImg handle:(QqcShareHandler)handler;

//对分享结果进行默认处理
+ (void)shareWithPlatformType:(QqcSharePlatformType)platformType contentType:(QqcShareContentType)contentType title:(NSString *)strTitle content:(NSString *)strContent url:(NSString *)strUrl musicFileURL:(NSString*)strMusicFileURL image:(NSString *)strImg parentVC:(UIViewController *)parentVC;

@end
