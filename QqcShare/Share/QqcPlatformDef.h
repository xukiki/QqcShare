//
//  PlatformDef.h
//  QqcShareSDK
//
//  Created by qiuqinchuan on 15/10/21.
//  Copyright © 2015年 Qqc. All rights reserved.
//

#ifndef PlatformDef_h
#define PlatformDef_h

//登录平台类型
typedef enum{
    QqcAuthLoginPlatformTypeUnknown = 0,
    QqcAuthLoginPlatformTypeQQ = 1,
    QqcAuthLoginPlatformTypeWX = 2,
    QqcAuthLoginPlatformTypeSina = 3,
} QqcAuthLoginPlatformType;

//分享平台类型
typedef enum{
    QqcSharePlatformTypeUnknown = 0,
    QqcSharePlatformTypeQQFriend = 1,
    QqcSharePlatformTypeQQZone = 2,
    QqcSharePlatformTypeSinaWeibo = 3,
    QqcSharePlatformTypeWeixinSession = 4,
    QqcSharePlatformTypeWeixinTimeline = 5,
    QqcSharePlatformTypeMsg = 6,
    QqcSharePlatformTypeCopy = 7,
    QqcSharePlatformTypeQRCode = 8,
} QqcSharePlatformType;

//分享内容类型
typedef enum{
    QqcShareContentText = 0,
    QqcShareContentImage = 1,
    QqcShareContentWebPage = 2,
    QqcShareContentAudio = 3,
    QqcShareContentVideo = 4,
    QqcShareContentApp = 5,
} QqcShareContentType;

//分享状态
typedef enum{
    QqcShareStatusBegin = 0,
    QqcShareStatusSuccess = 1,
    QqcShareStatusFail = 2,
    QqcShareStatusCancel = 3,
    QqcShareStatusPreCancel = 4,  //尚未点击分享类型，用户就取消了
} QqcShareStatusType;

#endif /* PlatformDef_h */
