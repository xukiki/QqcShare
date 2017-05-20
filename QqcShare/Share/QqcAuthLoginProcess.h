//
//  QqcAuthLoginProcess.h
//  QqcShareSDK
//
//  Created by qiuqinchuan on 15/10/21.
//  Copyright © 2015年 Qqc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QqcPlatformDef.h"



typedef void(^QqcAuthLoginSuccessHandler)(NSString* strUnionid, NSString* strName, NSString* strLogo, NSString* strSex);
typedef void(^QqcAuthLoginFailHandler)(NSString* strRet);

@interface QqcAuthLoginProcess : NSObject

/**
 *  第三方授权登录平台
 *
 *  @param paltType  授权登录平台类型
 *  @param strAppKey AppKey
 *  @param strSecret AppSecret
 *  @param handler   授权登录成功回调
 *  @param handler   授权登录失败回调
 */
+ (void)QqcAuthLogin:(QqcAuthLoginPlatformType)paltType sucHandle:(QqcAuthLoginSuccessHandler)handler failHandle:(QqcAuthLoginFailHandler)handler;

@end
