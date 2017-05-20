//
//  QqcAuthLoginProcess.m
//  QqcShareSDK
//
//  Created by qiuqinchuan on 15/10/21.
//  Copyright © 2015年 Qqc. All rights reserved.
//

#import "QqcAuthLoginProcess.h"
#import <ShareSDKExtension/SSEThirdPartyLoginHelper.h>

@implementation QqcAuthLoginProcess

+ (void)QqcAuthLogin:(QqcAuthLoginPlatformType)paltType sucHandle:(QqcAuthLoginSuccessHandler)handlerSuc failHandle:(QqcAuthLoginFailHandler)handlerFail
{
    [SSEThirdPartyLoginHelper loginByPlatform:SSDKPlatformTypeWechat
                                   onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
                                       //在此回调中可以将社交平台用户信息与自身用户系统进行绑定，最后使用一个唯一用户标识来关联此用户信息。
                                       //在此示例中没有跟用户系统关联，则使用一个社交用户对应一个系统用户的方式。将社交用户的uid作为关联ID传入associateHandler。
                                       //associateHandler (user.uid, user, user);
                                       NSLog(@"dd%@",user.rawData);
                                       NSLog(@"dd%@",user.credential);
                                       NSString* unionid = [user.rawData objectForKey:@"unionid"];
                                       handlerSuc(unionid, user.nickname, user.icon, [NSString stringWithFormat:@"%lu", (unsigned long)user.gender]);
                                   }
                                onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
                                    
                                    if (state != SSDKResponseStateSuccess)
                                    {
                                        NSString* strError = [NSString stringWithFormat:@"%@", error];
                                        handlerFail(strError);
                                    }
                                    
                                }];

}

@end
